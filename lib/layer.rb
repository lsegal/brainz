module Brainz
  class Layer
    include Enumerable
    
    attr_reader :network, :neurons, :id, :prev_layer, :next_layer

    def initialize(network, num_neurons)
      @network = network
      @neurons = ([nil]*num_neurons).map { Neuron.new(self) }
      @id = network.layers.size + 1
    end
    
    def connect_layers(prev_layer, next_layer)
      @prev_layer = prev_layer
      @next_layer = next_layer
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
    
    def calculate_deltas(expected_output = nil)
      return if first?
      if last?
        each.with_index {|n, i| n.calculate_delta(expected_output[i]) }
      else
        each(&:calculate_delta)
      end
    end
    
    def adapt
      return if first?
      debug "Layer #{id} ADAPTING"
      each(&:adapt)
    end
    
    def first?
      prev_layer.nil?
    end
    
    def last?
      next_layer.nil?
    end
  end
end