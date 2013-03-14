class EmSpamc::HeaderParser
  def self.parse(data)
    headers = {}

    stripped_data = data.gsub(/\r/, "")
    lines = stripped_data.split("\n")

    lines.each do |line|
      if (line.match(/^SPAMD\/(\d+\.\d+) (.*)/))
        code, message = $2.split(/\s+/)

        headers[:version] = $1
        headers[:code] = code.match(/\d/) ? code.to_i : code
        headers[:message] = message        
      elsif (line.match(/^(\S+): (.*)\s;\s([0-9]*.[0-9]*)/))
        headers[:spam] = $2 == 'True'
        headers[:score] = $3.to_f
      end
    end

    # Special case: if we only have one header line back, means score of 0
    headers.merge!(:score => 0.0, :spam => false) if lines.length == 1

    headers
  end
end