# rbga
## Introduction
Genetic Algorithm Rubygem, providing an expressive DSL to illustrate genetic algorithm problems and sets of default methods.

## Example

```ruby
# 20-queen

require 'rbga'
a = GA.new do 
    population_size 100
    chromosome_length 20
    chromosome_type :permutation
    crossover_method :order_crossover
    mutation_method :inversion
    mutation_probability 50
    selection_method :two_tournament
    survive_method :min_fitness
end

a.set_fitness_eval do |chromosome|
    attacks = 0
    chromosome.each_index do |col|
        upper = chromosome[col]
        lower = chromosome[col]
        (1..col).each do |x|
            idx = col-x
            upper-=1
            lower+=1
            attacks+=1 if chromosome[idx]==upper or chromosome[idx]==lower
        end
    end
    attacks
end

a.evolve 100
p a.best, a.best.fitness
```
