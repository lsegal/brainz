require 'pp'
require File.dirname(__FILE__) + '/spec_helper'

describe Brainz::Network do
  describe 'training simple boolean logic' do
    before do
      @net = Network.new(2, 2, 1)
    end
    
    def train(training_data)
      1000.times do
        training_data.each do |input, output|
          @net.train(input, output)
        end
      end
    end
    
    it "should train an AND gate" do
      training_data = {
        [0, 0] => [0],
        [0, 1] => [0],
        [1, 0] => [0],
        [1, 1] => [1]
      }
      train(training_data)
      
      #pp @net.layers.first

      training_data.keys.each do |input|
        p input => @net.run(input)
      end
    end
  end
end