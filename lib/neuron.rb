module Brainz
  class Neuron
    attr_reader :output, :weights, :layer, :bias, :delta
    
    LEARNING_RATE = 0.5
    
    def initialize(layer)
      @layer = layer
    end
    
    def initialize_weights
      return if layer.first?
      srand
      @weights = prev_layer.map { rand }
      @bias = rand
    end
        
    def prev_layer; layer.prev_layer end
    def next_layer; layer.next_layer end
    
    def fire(input)
      debug "Neuron in layer #{layer.id} firing with #{input.inspect}"
      if layer.first?
        @output = input
      else
        output = bias
        prev_layer.each.with_index do |neuron, i|
          output += weights[i] * neuron.output
        end
        @output = layer.network.transfer_function.call(output)
      end
    end
    
    def calculate_delta(expected_value = nil)
      @delta = output * (1 - output) * error_factor(expected_value)
      debug "Neuron in layer #{layer.id} calculating with #{error_factor(expected_value)}: #{@delta}"
    end
    
    def adapt
      @bias += LEARNING_RATE * delta
      debug "Neuron in layer #{layer.id} adapting: #{@bias}"
      prev_layer.each.with_index do |neuron, i|
        @weights[i] += LEARNING_RATE * neuron.output * delta
      end
    end
    
    protected
    
    def error_factor(expected_value = nil)
      if layer.last? && expected_value
        expected_value - output
      else
        next_layer.map.with_index do |neuron, i|
          neuron.delta * neuron.weights[i]
        end.inject(:+)
      end
    end
  end
end
