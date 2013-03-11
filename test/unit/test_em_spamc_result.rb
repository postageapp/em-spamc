require_relative '../helper'

class TestEmSpamcConnection < Test::Unit::TestCase
  def test_defaults
    result = EmSpamc::Result.new

    assert_equal nil, result.code
  end

  def test_assignment
    result = EmSpamc::Result.new

    assert_equal nil, result.code

    result.code = 0

    assert_equal 0, result.code
  end
end
