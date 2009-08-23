module Brainz
  class Layer
    include Enumerable
    
    attr_accessor :prev_layer, :next_layer
    attr_reader :neurons, :id

    @@layer_num = 0
    
    def initialize(num_neurons)
      @neurons = ([nil]*num_neurons).map { Neuron.new(self) }
      @id = (@@layer_num += 1)
    end
    
    def prev_layer=(prev)
      @prev_layer = prev
      each(&:initialize_weights)
    end
    
    def each(*args, &block) neurons.each(*args, &block) end
    
    def fire(input)
      debug "Layer #{id} firing with #{input.inspect}"
      debug "  - Weights: #{neurons.map {|n| n.weights }.inspect}"
      output = neurons.map.with_index do |neuron, i|
        neuron.fire(input[i])
      end
      
      last? ? output : next_layer.fire(output)
    end
    
    def adapt(expected_output = nil)
      debug "Layer #{id} ADAPT with #{expected_output.inspect}"
      if last?
        each.with_index do |neuron, i| 
          neuron.calculate_delta(expected_output[i] - neuron.output)
        end
      end

      return if first? || prev_layer.first?
      prev_layer.each.with_index do |neuron, i| 
        error_factor = map {|t| t.weights[i] * t.delta }.inject(:+)
        neuron.calculate_delta(error_factor)
      end
      
      prev_layer.adapt
      prev_layer.each(&:adapt)
      each(&:adapt) if last?
    end
    
    def first?
      prev_layer.nil?
    end
    
    def last?
      next_layer.nil?
    end
  end
end