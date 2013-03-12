require_relative '../helper'

class TestEmSpamcConnection < Test::Unit::TestCase
  def test_ping
    eventmachine do
      result = EmSpamc::Connection.ping(connection_options)

      assert result
    end
  end

  def test_symbols
    eventmachine do
      message = example_message(:sample)

      result = EmSpamc::Connection.symbols(message, connection_options)

      assert result
    end
  end

  def test_report
    eventmachine do
      message = example_message(:sample)

      result = EmSpamc::Connection.report(message, connection_options)

      assert result
    end
  end
end
