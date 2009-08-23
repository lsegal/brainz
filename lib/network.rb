module Brainz
  class Network
    attr_reader :layers
    
    def initialize(*neurons_per_layer)
      @layers = neurons_per_layer.map {|n| Layer.new(n) }
      connect_layers
    end
    
    def train(input, expected_output)
      run(input)
      layers.last.adapt(expected_output)
    end
    
    def run(input)
      layers.first.fire(input)
    end
    
    private
    
    def connect_layers
      @layers.each.with_index do |layer, i|
        layer.prev_layer = i == 0 ? nil : @layers[i - 1]
        layer.next_layer = @layers[i + 1]
      end
    end
  end
end