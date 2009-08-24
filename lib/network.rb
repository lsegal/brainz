module Brainz
  class Network
    attr_reader :layers
    attr_accessor :transfer_function
    
    HARD_LIMIT_FUNCTION = ->(v) { v < 0.5 ? 0 : 1 }
    SIGMOID_FUNCTION = ->(v) { 1 / (1 + Math.exp(-v)) }
    
    def initialize(*neurons_per_layer)
      @layers = []
      @layers = neurons_per_layer.map {|n| Layer.new(self, n) }
      @transfer_function = SIGMOID_FUNCTION
      connect_layers
    end
    
    def train(input, expected_output)
      run(input)
      layers.reverse.each {|l| l.calculate_deltas(expected_output) }
      layers.each(&:adapt)
    end
    
    def run(input)
      layers.first.fire(input)
    end
    
    private
    
    def connect_layers
      @layers.each.with_index do |layer, i|
        prev_layer = i == 0 ? nil : @layers[i - 1]
        next_layer = @layers[i + 1]
        layer.connect_layers(prev_layer, next_layer)
      end
    end
  end
end