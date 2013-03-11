require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'em-spamc'
require 'eventmachine'

class Test::Unit::TestCase
  def example_message(name)
    message_path = File.expand_path("examples/#{name}.txt", File.dirname(__FILE__))

    File.open(message_path).read
  end

  def connection_options
    config_file = File.expand_path('config/spamassassin.yml', File.dirname(__FILE__))

    Hash[
      YAML.load(File.open(config_file)).collect do |key, value|
        [ key.to_sym, value ]
      end
    ]
  end

  def eventmachine
    EventMachine.run do
      EventMachine.add_periodic_timer(1) do
        puts Time.now.to_i
      end

      Fiber.new do
        yield
        EventMachine.stop_event_loop
      end.resume
    end
  end
end
