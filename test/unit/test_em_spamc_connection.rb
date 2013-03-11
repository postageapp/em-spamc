require_relative '../helper'

class TestEmSpamcConnection < Test::Unit::TestCase
  def ztest_ping
    eventmachine do
      result = EmSpamc::Connection.ping(connection_options)

      assert result

      puts result.inspect
    end
  end

  def xtest_symbols
    eventmachine do
      message = example_message(:sample)

      result = EmSpamc::Connection.symbols(message, connection_options)

      assert result

      puts result.inspect
    end
  end

  def test_report
    eventmachine do
      message = example_message(:sample)

      result = EmSpamc::Connection.report(message, connection_options)

      assert result

      puts result.inspect
    end
  end
end
