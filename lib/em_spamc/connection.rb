require 'fiber'
require 'eventmachine'

class EmSpamc::Connection < EventMachine::Connection
  # == Constants ============================================================

  PROTO_VERSION = 'SPAMC/1.2'.freeze

  DEFAULT_OPTIONS = {
    :host => 'localhost',
    :port => 783
  }.freeze

  # == Properties ===========================================================

  attr_reader :error

  # == Class Methods ========================================================

  def self.check(message, options = nil)
    request('CHECK', message, options)
  end
  
  def self.symbols(message, options = nil)
    request('SYMBOLS', message, options)
  end

  def self.report(message, options = nil)
    request('REPORT', message, options)
  end

  def self.ping(options = nil)
    request('PING', nil, options)
  end

  def self.request(command, message, options = nil)
    if (options)
      options = DEFAULT_OPTIONS.merge(options)
    else
      options = DEFAULT_OPTIONS
    end

    EventMachine.connect(
      options[:host],
      options[:port],
      self,
      [
        Fiber.current,
        command,
        message
      ]
    )

    Fiber.yield
  end

  # == Instance Methods =====================================================

  def initialize(options)
    @fiber = options[0]
    @command = options[1]
    @message = options[2] && (options[2].gsub(/\r?\n/, "\r\n") + "\r\n")
    @error = nil
    @data = nil
  end

  # EventMachine hook that's engaged after the client is initialized.
  def post_init
    if (error?)
      @fiber.resume
    else
      send_data("#{@command} #{PROTO_VERSION}\r\n")

      if (@message)
        send_data("Content-length: #{@message.bytesize}\r\n")
        send_data("\r\n")
        send_data(@message)
      else
        send_data("\r\n")
      end
    end
  end

  def receive_data(data)
    @data ||= ''
    @data << data
  end

  def unbind
    result = EmSpamc::Result.new

    if (@data)
      result.headers = EmSpamc::HeaderParser.parse(@data)

      case (@command)
      when 'REPORT'
        result.report = EmSpamc::ReportParser.parse(@data)
      end
    end

    @fiber.resume(result)
  end

  def error?
    !!@error
  end
end
