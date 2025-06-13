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

  context 'with input Aa' do
    let(:skus) { 'Aa' }

    it 'returns -1' do
      expect(service_call).to eq(-1)
    end
  end

  context 'with input containing item without special offer' do
    let(:skus) { 'CCD' }
    let(:expected_sum) { 2*20 + 1*15 }

    it 'returns the correct checkout sum' do
      expect(service_call).to eq(expected_sum)
    end
  end
end



