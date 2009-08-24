Brainz
======

Brainz is a Artificial Neural Network (ANN) library written by Loren Segal.
Neural networks are generally used in pattern recognition, signal processing
and other data intensive processing problems. ANN's benefit by not having to
explicitly define the procedural steps involved in the problem, but rather by
_training_ the neural network to return the correct output for the respective
inputs. This means that the same neural network can be applied to many 
different problem sets without much (sometimes any) modification, and therefore
make a good general solution to a large set of problem domains. The drawback,
however, is that these neural networks require large sets of data to be trained
and this training process can be processor intensive.

More information on Artificial Neural Networks can be found on Wikipedia and
elsewhere:

  * [http://en.wikipedia.org/wiki/Artificial_Neural_Network](http://en.wikipedia.org/wiki/Artificial_Neural_Network)
  * [http://en.wikipedia.org/wiki/Artificial_Neuron](http://en.wikipedia.org/wiki/Artificial_Neuron)
  * [http://www.doc.ic.ac.uk/~nd/surprise_96/journal/vol4/cs11/report.html](http://www.doc.ic.ac.uk/~nd/surprise_96/journal/vol4/cs11/report.html)

Installation & Requirements
---------------------------

**Note: this library requires Ruby 1.9**

    sudo gem install brainz

Examples
--------

A simple neural network to calculate the bitwise AND operator, 1 & 1, can be
defined as:

    # Define a 2-2-1 neural network
    net = Brainz::Network.new(2, 2, 1) 
    
    # We must train the system first
    1000.times do 
      net.train([0, 0], [0])
      net.train([0, 1], [0])
      net.train([1, 0], [0])
      net.train([1, 1], [1])
    end
    
    # Now some tests:
    p net.run([0, 1]).map(&:round) # => [0]
    p net.run([1, 1]).map(&:round) # => [1]
    
Simply changing the dataset used in training can create a neural network 
designed to calculate the OR or XOR operation.

License & Copyright
-------------------

MIT License. Copyright 2009.