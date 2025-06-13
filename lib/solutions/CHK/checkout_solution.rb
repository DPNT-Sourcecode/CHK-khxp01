# noinspection RubyUnusedLocalVariable
class CheckoutSolution

  def checkout(skus)
    item_count = %w[A B C D].map { |sku| { sku => skus.upcase.count(sku) } }
  end

end

