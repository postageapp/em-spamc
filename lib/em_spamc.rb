require 'fiber'

module EmSpamc
  autoload(:Connection, 'em_spamc/connection')
  autoload(:Result, 'em_spamc/result')
  autoload(:ReportParser, 'em_spamc/report_parser')
end
