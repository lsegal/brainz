def __p(file)
  File.join(File.dirname(__FILE__), file.to_s)
end

module Brainz
  autoload :Layer, __p(:layer)
  autoload :Neuron, __p(:neuron)
  autoload :Network, __p(:network)
end

def debug(*msg)
  puts(*msg) if $DEBUG
end

undef __p