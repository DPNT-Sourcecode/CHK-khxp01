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

  xcontext 'with input containing item without multi price offer' do
    let(:skus) { 'CCD' }
    let(:expected_sum) { 2*20 + 1*15 }

    it 'returns the sum using the regular prices' do
      expect(service_call).to eq(expected_sum)
    end
  end

  xcontext 'with input containing item with a single multi price offer' do
    context 'when all items can be covered by the multi price offer' do
      let(:skus) { 'BBBB' }
      let(:expected_sum) { 2*45 }

      it 'applies the multi price offer price to the items' do
        expect(service_call).to eq(expected_sum)
      end
    end

    context 'when no items can be covered by the multi price offer' do
      let(:skus) { 'B' }
      let(:expected_sum) { 1*30 }

      it 'applies the regular price to the items' do
        expect(service_call).to eq(expected_sum)
      end
    end

    context 'when only some items can be covered by the multi price offer' do
      let(:skus) { 'BBB' }
      let(:expected_sum) { 1*45 + 1*30 }

      it 'applies the regular price to the items' do
        expect(service_call).to eq(expected_sum)
      end
    end
  end

  xcontext 'with input containing item with multiple multi price offers' do
    let(:skus) { 'AAAAAAAAA' }
    let(:expected_sum) { 1*200 + 1*130 + 50 }

    it 'returns the most beneficial multi price offer price' do
      expect(service_call).to eq(expected_sum)
    end
  end

  xcontext 'when input contains item with free product offer' do
    context 'when the free product is of a different sku' do
      let(:skus) { 'EEBB' }
      let(:expected_sum) { 2*40 + 1*30 } # 1 B free

      it 'returns the expected price' do
        expect(service_call).to eq(expected_sum)
      end
    end

    context 'when the free product is of the same sku' do
      let(:skus) { 'FFFF' }
      let(:expected_sum) { 3*10 } # 1 F free

      it 'returns the expected price' do
        expect(service_call).to eq(expected_sum)
      end
    end
  end

  context 'when input contains all products twice' do
    #let(:skus) { 'ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ' } # 1880 / 1850
    let(:skus) { 'LGCKAQXFOSKZGIWHNRNDITVBUUEOZXPYAVFDEPTBMQLYJRSMJCWH' } # 1880 / 1850
    let(:expected_sum) { 2*50 + 1*30 + 2*20 + 2*15 + 2*40 + 2*10 + 2*20 + 2*10 + 2*35 + 2*60 + 150 + 2*90 + 2*15 + 2*40 + 2*10 + 2*50 + 2*30 + 2*50 + 2*30 + 2*20 + 2*40 + 90 + 2*20 + 2*90 + 2*10 + 2*50 }

    it 'returns the expected price' do
      expect(service_call).to eq(expected_sum)
    end
  end
end




