require_relative './bubble-sort'
require 'rspec'

describe '#bubble_sort' do
	it "Correctly sorts an mixed array" do
		expect(bubble_sort([4,21,112,2,1,5,0])).to eq [0,1,2,4,5,21,112]
	end

	it "Correctly sorts an mixed array with a block" do
		expect(bubble_sort_by(["hi","hello","hey"])  {|left,right| right.length - left.length}).to eq ["hi","hey","hello"]
	end
end
