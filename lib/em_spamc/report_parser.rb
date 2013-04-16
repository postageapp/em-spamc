class EmSpamc::ReportParser
  LINE_REGEXP = /-$/
  RULE_REGEXP = /[0-9]*[.][0-9]\s\w*\s/

  def self.parse(data)
    split_data = data.split(LINE_REGEXP)    

    # Only status line is back - no report returned, no rules
    if (split_data.length == 1)
      return [ ]
    end

    last_part = split_data[1].sub(/^[\n\r]./,'').chomp.chomp
    
    points_rules = last_part.gsub(RULE_REGEXP).collect do |sub|
      sub.chomp(' ')
    end

    rule_texts = last_part.split(RULE_REGEXP).collect do |text|
      text.delete("\n").squeeze.chomp(' ').sub(/^\s/, '')
    end

    rules = [ ]

    points_rules.each_with_index do |points_rule, i|
      split = points_rule.split(' ')

      rules << {
        :pts => split[0].to_f,
        :rule => split[1],
        :text => rule_texts[i + 1]
      }
    end

    rules
  end
end
