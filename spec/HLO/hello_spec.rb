require_solution 'HLO'

describe HelloSolution do
  context 'when friend_name is present' do
    it "returns the expected string" do
      expect(HelloSolution.new.hello('Nuno')).to eq 'Hello Nuno!'
    end
  end

  context 'when friend_name is present' do
    it "returns the expected string" do
      expect(HelloSolution.new.hello(nil)).to eq 'Hello World!'
    end
  end 
end



