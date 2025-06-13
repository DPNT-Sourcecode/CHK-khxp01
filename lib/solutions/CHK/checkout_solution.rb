# noinspection RubyUnusedLocalVariable
class CheckoutSolution

  PRICES = {
    A: { price: 50, special_quantity: 3, special_price: 130 },
    B: { price: 30, special_quantity: 2, special_price: 45 },
    C: { price: 20 },
    D: { price: 15 }
  }.freeze

  def checkout(skus)
    return -1 if skus.nil? || skus.class != String || %w[A B C D].none? { |el| skus.include?(el) }

    item_count = Hash[%w[A B C D].map { |sku| [sku, skus.count(sku)] }]

    item_count.reduce(0) do |sum, (sku, quantity)|
      price_table = PRICES[sku.to_sym]

      sum += quantity / price_table[:special_quantity] * price_table[:special_price] if %w[A B].include?(sku)

      regular_price_count = %w[A B].include?(sku) ? quantity % price_table[:special_quantity] : quantity

      sum += price_table[:price] * regular_price_count
    end
  end
end



