class EmSpamc::HeaderParser
  def self.parse(data)
    lines = data.split(/\r?\n/)
    headers = { }

    lines.each do |line|
      case (line)
      when /^SPAMD\/(\d+\.\d+) (.*)/
        code, message = $2.split(/\s+/)

        headers[:version] = $1
        headers[:code] = code.match(/\d/) ? code.to_i : code
        headers[:message] = message        
      when /^(\S+): (.*)\s;\s([0-9]*.[0-9]*)/
        headers[:spam] = $2 == 'True'
        headers[:score] = $3.to_f
      end
    end

    # Special case: if we only have one header line back, means score of 0
    if (lines.length == 1)
      headers.merge!(:score => 0.0, :spam => false)
    end

    headers
  end
end
