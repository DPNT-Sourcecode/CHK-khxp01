require_solution 'HLO'

describe HelloSolution do
  let(:expected_string) { 'Hello, World!'}

  context 'when friend_name is present' do
    it "returns the expected string" do
      expect(HelloSolution.new.hello('Nuno')).to eq expected_string
    end
  end

  context 'when friend_name is present' do
    it "returns the expected string" do
      expect(HelloSolution.new.hello(nil)).to eq expected_string
    end
  end 
end


