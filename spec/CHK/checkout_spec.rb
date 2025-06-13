require_solution 'CHK'

describe CheckoutSolution do
  let(:service_call) { CheckoutSolution.new.checkout(skus) }
  let(:skus) { 'AABCADDA' }

  it '' do
    expect(service_call).to ''
  end
end

