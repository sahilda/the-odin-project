require 'rspec'
require_relative './stock-picker'

describe '#stock_picker' do
    it 'Correctly selects the best buy and sell date' do
        stock_picker([17,3,6,9,15,8,6,1,10]).should == [1,4]
    end
end
