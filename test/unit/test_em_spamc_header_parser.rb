require_relative '../helper'

class TestEmSpamcHeaderParser < Test::Unit::TestCase
  def test_score_header
    report = example_report('spam-report')
    headers = EmSpamc::HeaderParser.parse(report)
    assert_equal headers[:spam], true
    assert headers[:score] >= 0
  end

  def test_zero_header
    report = example_report('zero-report')
    headers = EmSpamc::HeaderParser.parse(report)
    assert headers[:score]
    assert_equal headers[:score], 0
    assert_equal headers[:spam], false
  end
end