# garb
## Introduction
Genetic Algorithm Rubygem, providing an expressive DSL to illustrate genetic algorithm problems and sets of default methods.

## Example

```ruby
require 'garb'
a = GA.new do 
	population_size 10
    chromosome_length 100
	chromosome_type :permutation
	crossover_method :order_crossover
	mutation_method :inversion
    mutation_probability 50
	selection_method :two_tournament
	survive_method :max_fitness
end

a.set_fitness_eval do |chromosome|
    chromosome[0] + chromosome[-1]
end

a.evolve 100
print a.best
```
