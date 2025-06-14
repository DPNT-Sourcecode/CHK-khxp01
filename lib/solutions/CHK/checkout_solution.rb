# noinspection RubyUnusedLocalVariable
require 'byebug'
class CheckoutSolution

  ITEMS = %w[A B C D E F].freeze

  GENERAL_PRICES = {
    'A' => 50, 'B' => 30, 'C' => 20, 'D' => 15, 'E' => 40, 'F' => 10
  }.freeze

  BULK_BUY_OFFERS = {
    'A' => [{ quantity: 3, price: 130 }, { quantity: 5, price: 200 }],
    'B' => [{ quantity: 2, price: 45 }]
  }.freeze

  FREE_PRODUCT_OFFERS = {
    'E' => { quantity: 2, sku: 'B' },
    'F' => { quantity: 2, sku: 'F' }
  }.freeze

  def checkout(skus)
    return -1 if skus.nil? || skus.class != String || skus.chars.any? { |ch| !ITEMS.include?(ch) }

    item_counts = get_item_counts(skus)

    FREE_PRODUCT_OFFERS.each do |sku, offer|
      byebug
      needed_quantity = sku == offer[:sku] ? offer[:quantity] + 1 : offer[:quantity]
      free_item_count = item_counts[sku] / needed_quantity

      item_counts[offer[:sku]] = [item_counts[offer[:sku]] - free_item_count, 0].max
    end

    calculate_sum(item_counts)
  end

  private

  def get_item_counts(skus)
    Hash[ITEMS.map { |sku| [sku, skus.count(sku)] }]
  end

  def calculate_sum(item_counts)
    sum = 0

    item_counts.each do |sku, quantity|
      if BULK_BUY_OFFERS[sku]
        BULK_BUY_OFFERS[sku].sort_by { |offer| -offer[:quantity] }.each do |offer|
          sum += quantity / offer[:quantity] * offer[:price]
          quantity %= offer[:quantity]
        end
      end

      sum += quantity * GENERAL_PRICES[sku]
    end

    sum
  end
end


