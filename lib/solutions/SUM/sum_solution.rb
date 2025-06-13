# noinspection RubyUnusedLocalVariable
class SumSolution
  class SumError < StandardError; end

  def compute(x, y)
    raise SumError, "#{x} is not a postive integer between 0-100" if x < 0 || x > 100
    raise SumError, "#{y} is not a postive integer between 0-100" if y < 0 || y > 100

    #x + y
  end
end
