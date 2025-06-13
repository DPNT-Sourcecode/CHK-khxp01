# noinspection RubyUnusedLocalVariable
require 'byebug'
class CheckoutSolution

  PRICES = {
    A: { price: 50, special_offers: [ { quantity: 3, price: 130 }, { quantity: 5, price: 200 } ] },
    B: { price: 30, special_quantity: 2, special_price: 45 },
    C: { price: 20 },
    D: { price: 15 }
  }.freeze

  def checkout(skus)
    return -1 if skus.nil? || skus.class != String || skus.chars.any? { |ch| !%w[A B C D].include?(ch) }

    item_counts = get_item_counts(skus)

    calculate_sum(item_counts)
  end

  private

  def get_item_counts(skus)
    Hash[%w[A B C D].map { |sku| [sku, skus.count(sku)] }]
  end

  def calculate_sum(item_counts)
    item_counts.reduce(0) do |sum, (sku, quantity)|
      price_table = PRICES[sku.to_sym]

      sum += calculate_special_price(quantity, price_table) if %w[A B].include?(sku)

      regular_price_count = %w[A B].include?(sku) ? quantity % price_table[:special_quantity] : quantity

      sum += price_table[:price] * regular_price_count
    end
  end

  def calculate_special_price(quantity, price_table)
    quantity / price_table[:special_quantity] * price_table[:special_price]
  end
end



