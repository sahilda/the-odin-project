require_relative './caesar-cipher'
require 'rspec'

describe '#caesar_cipher' do
    it "Correctly encrypts the following message" do
        caesar_cipher("What a string!", 5).should == "Bmfy f xywnsl!"
    end
end


