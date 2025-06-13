# noinspection RubyUnusedLocalVariable
class CheckoutSolution

  def checkout(skus)
    %w[A B C D].map { |sku| { sku => skus.upcase.count(sku) } }
    item_count = { A: , B:, C:, D:}
  end

end
