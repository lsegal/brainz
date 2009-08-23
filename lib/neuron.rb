module Brainz
  class Neuron
    attr_reader :output, :weights, :layer, :bias, :delta
    attr_accessor :transfer
    
    LEARNING_RATE = 0.5
    
    HARD_LIMIT_FUNCTION = ->(v) { v < 0.5 ? 0 : 1 }
    SIGMOID_FUNCTION = ->(v) { 1 / (1 + Math.exp(-v)) }

    def initialize(layer)
      @layer = layer
      @transfer = HARD_LIMIT_FUNCTION
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
          output += weights[i] * input
        end
        @output = transfer.call(output)
      end
    end
    
    def calculate_delta(error_factor)
      @delta = output * (1 - output) * error_factor
      debug "Neuron in layer #{layer.id} calculating with #{error_factor}: #{@delta}"
    end
    
    def adapt
      @bias += LEARNING_RATE * delta
      debug "Neuron in layer #{layer.id} adapting: #{@bias}"
      prev_layer.each.with_index do |neuron, i|
        @weights[i] += LEARNING_RATE * neuron.output * delta
      end
    end
  end
end
