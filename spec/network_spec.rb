require 'pp'
require File.dirname(__FILE__) + '/spec_helper'

describe Brainz::Network do
  describe 'training simple boolean logic' do
    before do
      @net = Network.new(2, 2, 1)
    end
    
    def train(training_data, num_times = nil)
      (num_times || 1000).times do
        training_data.each do |input, output|
          @net.train(input, output)
        end
      end
    end
    
    def run(training_data)
      training_data.each do |input, output|
        @net.run(input).map(&:round).should == output
      end
    end
    
    def test(data, num_times = nil)
      train(data, num_times)
      run(data)
    end
    
    it "should train an AND gate" do
      test({
        [0, 0] => [0],
        [0, 1] => [0],
        [1, 0] => [0],
        [1, 1] => [1]
      })
    end

    it "should train an OR gate" do
      test({
        [0, 0] => [0],
        [0, 1] => [1],
        [1, 0] => [1],
        [1, 1] => [1]
      })
    end

    it "should train an XOR gate" do
      test({
        [0, 0] => [0],
        [0, 1] => [1],
        [1, 0] => [1],
        [1, 1] => [0]
      }, 10000)
    end
  end
end