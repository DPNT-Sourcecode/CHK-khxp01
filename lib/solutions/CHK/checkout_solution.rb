# noinspection RubyUnusedLocalVariable
require 'byebug'
class CheckoutSolution

  GENERAL_PRICES = {
    A: 50, B: 30, C: 20, D: 15, E: 40
  }.freeze

  BULK_BUY_OFFERS = {
    A: [{ quantity: 3, price: 130 }, { quantity: 5, price: 200 }],
    B: [{ quantity: 2, price: 45 }]
  }.freeze

  FREE_PRODUCT_OFFERS = {
    E: { quantity: 2, sku: 'B' }
  }.freeze

  def checkout(skus)
    return -1 if skus.nil? || skus.class != String || skus.chars.any? { |ch| !%w[A B C D].include?(ch) }

    item_counts = get_item_counts(skus)

    FREE_PRODUCT_OFFERS.each do |sku, offer|
      byebug
      free_item_count = item_counts[sku] / offer[:quantity]

      item_counts[offer[:sku]] = [item_counts[offer[:sku]] - free_item_count, 0].max
    end

    calculate_sum(item_counts)
  end

  private

  def get_item_counts(skus)
    Hash[%i[A B C D].map { |sku| [sku, skus.count(sku.to_s)] }]
  end

  def calculate_sum(item_counts)
    sum = 0

    item_counts.reduce(0) do |sum, (sku, quantity)|
      price_table = PRICES[sku.to_sym]
      
      if price_table[:special_offers].nil?
        sum += quantity * price_table[:price]

        next sum
      end

      sum += calculate_special_price(quantity, price_table)
    end

    item_counts.each do |sku, quantity|
      BULK_BUY_OFFERS[sku].sort_by { |offer| -offer[:quantity] }.each do |offer|
        sum += quantity / offer[:quantity] * offer[:price]
        quantity %= offer[:quantity]
      end

      sum += quantity * GENERAL_PRICES[sku]
    end
  end
end


