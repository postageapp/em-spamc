require_relative '../helper'

class TestEmSpamcConnection < Test::Unit::TestCase
  def test_defaults
    result = EmSpamc::Result.new

    assert_equal nil, result.headers
    assert_equal nil, result.report
  end

  def test_assignment
    result = EmSpamc::Result.new

    assert_equal nil, result.headers
    
    result.headers = { :code => 0 }

    assert_equal 0, result.headers[:code]
  end
end
