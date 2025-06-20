# noinspection RubyResolve,RubyResolve
require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'SUM'

class ClientTest < Minitest::Test

  def test_sum
    assert_equal 3, SumSolution.new.compute(1, 2), 'App should add two numbers'

    assert_raises(SumSolution::SumError) do
      SumSolution.new.compute(-1, 2)
    end
  end
end
