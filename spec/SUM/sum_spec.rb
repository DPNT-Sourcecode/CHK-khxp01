require_solution 'SUM'

context 'when inputs are in range' do
  it 'adds the numbers' do
    expect(SumSolution.new.compute(1, 2).to eq(3))
  end
end

context 'when an input is out of range' do
  it 'raises an error' do
    expect { SumSolution.new.compute(-1, 2).to raise_error(SumSolution::SumError).with_message('-1 is not a postive integer between 0-100')}
  end
end