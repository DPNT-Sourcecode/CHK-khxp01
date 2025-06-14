# noinspection RubyUnusedLocalVariable
require 'byebug'
class CheckoutSolution

  ITEMS = ('A'..'Z').to_a.freeze

  GENERAL_PRICES = {
    'A' => 50, 'B' => 30, 'C' => 20, 'D' => 15, 'E' => 40, 'F' => 10,
    'G' => 20, 'H' => 10, 'I' => 35, 'J' => 60, 'K' => 70, 'L' => 90,
    'M' => 15, 'N' => 40, 'O' => 10, 'P' => 50, 'Q' => 30, 'R' => 50,
    'S' => 20, 'T' => 20, 'U' => 40, 'V' => 50, 'W' => 20, 'X' => 17,
    'Y' => 20, 'Z' => 21
  }.freeze

  MULTI_PRICE_OFFERS = {
    'A' => [{ quantity: 3, price: 130 }, { quantity: 5, price: 200 }],
    'B' => [{ quantity: 2, price: 45 }],
    'H' => [{ quantity: 5, price: 45 }, { quantity: 10, price: 80 }],
    'K' => [{ quantity: 2, price: 120 }],
    'P' => [{ quantity: 5, price: 200 }],
    'Q' => [{ quantity: 3, price: 80 }],
    'V' => [{ quantity: 2, price: 90 }, { quantity: 3, price: 130 }],
  }.freeze

  FREE_PRODUCT_OFFERS = {
    'E' => { quantity: 2, sku: 'B' },
    'F' => { quantity: 2, sku: 'F' },
    'N' => { quantity: 3, sku: 'M' },
    'R' => { quantity: 3, sku: 'Q' },
    'U' => { quantity: 3, sku: 'U' }
  }.freeze

  GROUP_DISCOUNT_OFFERS = {
    %w[S T X Y Z] => { quantity: 3, price: 45 }
  }.freeze

  def checkout(skus)
    return -1 if skus.nil? || skus.class != String || skus.chars.any? { |ch| !ITEMS.include?(ch) }

    item_counts = get_item_counts(skus)

    FREE_PRODUCT_OFFERS.each do |sku, offer|
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

    GROUP_DISCOUNT_OFFERS.each do |group, offer|
      group_quantity = item_counts.slice(*group).values.reduce(:+)
      group_count = group_quantity / offer[:quantity]
      sum += group_count * offer[:price]
      items_to_eliminate_from_count = offer[:quantity] * group_count

      group_skus = group.sort_by { |sku| -GENERAL_PRICES[sku] }

      while items_to_eliminate_from_count > 0
        updated_count = [item_counts[group_skus.first] - items_to_eliminate_from_count, 0].max
        items_to_eliminate_from_count = items_to_eliminate_from_count - item_counts[group_skus.first]
        item_counts[group_skus.first] = updated_count
        group_skus.shift
      end
    end

    item_counts.each do |sku, quantity|
      if MULTI_PRICE_OFFERS[sku]
        MULTI_PRICE_OFFERS[sku].sort_by { |offer| -offer[:quantity] }.each do |offer|
          sum += quantity / offer[:quantity] * offer[:price]
          quantity %= offer[:quantity]
        end
      end

      sum += quantity * GENERAL_PRICES[sku]
    end

    sum
  end
end

