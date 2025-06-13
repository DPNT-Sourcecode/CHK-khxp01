require_solution 'CHK'

describe CheckoutSolution do
  let(:service_call) { CheckoutSolution.new.checkout(skus) }

  context 'when input is nil' do
    let(:skus) { nil }

    it 'returns -1' do
      expect(service_call).to eq(-1)
    end
  end

  context 'when input is not a string' do
    let(:skus) { 555 }

    it 'returns -1' do
      expect(service_call).to eq(-1)
    end
  end

  context 'with input AABACDDA' do
    let(:skus) { 'AABADDA' } # A -> 1*130 + 1*50, B -> 1*30, C -> 0*20, D -> 2*15
    let(:expected_sum) { 1*130 + 1*50 + 1*30 + 0*20 + 2*15 }

    it 'returns the correct checkout sum' do
      expect(service_call).to eq(expected_sum)
    end
  end
end



