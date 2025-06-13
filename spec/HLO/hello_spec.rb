require_solution 'HLO'

describe HelloSolution do
  it "returns the expected string" do
    expect(HelloSolution.new.hello('Nuno')).to eq "Hello, Nuno!"
  end
end



