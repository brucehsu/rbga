require 'chromosome_type'
require 'mutation_methods'
require 'crossover_methods'
require 'selection_methods'
require 'survive_methods'

class GA
    attr_reader :best_log, :avg_log
    include CrossoverMethods
    include SelectionMethods
    include SurviveMethods

    def initialize(&block)
        instance_eval &block
        @population = Population.new @population_size, @chromosome_type, @chromosome_length, @mutation_method, @mutation_probability
        @best_log = []
        @avg_log = []
    end

    def chromosome_type(type)
        @chromosome_type = type
    end

    def chromosome_length(len)
        @chromosome_length = len
    end

    def population_size(size)
        @population_size = size
    end

    def crossover_method(crossover)
        @crossover_method = crossover
    end

    def mutation_method(mutation)
        @mutation_method = mutation
    end

    def mutation_probability(prob)
        @mutation_probability = prob
    end

    def selection_method(selection)
        @selection_method = selection
    end

    def survive_method(survive)
        @survive_method = survive
    end

    def evolve(generations)
        generations.times do |i|
            offspring = Population.new @population_size, @chromosome_type, @chromosome_length, @mutation_method, @mutation_probability
            offspring.clear
            offspring << @population
            offspring.flatten!(1)
            @population.size.times do |i|
                chs1 = @population[select]
                chs2 = @population[select]
                while chs1==chs2
                    chs2 = @population[select]
                end
                new_chs = crossover(chs1,chs2)
                while offspring.include?(new_chs[0]) or offspring.include?(new_chs[1])
                    chs1 = @population[select]
                    chs2 = @population[select]
                    while chs1==chs2
                        chs2 = @population[select]
                    end
                    new_chs = crossover(chs1,chs2)
                end
                offspring << new_chs[0] << new_chs[1]
            end
            survive offspring
            @best_log << best.fitness
            @avg_log << avg
        end

    end

    def select
        send(@selection_method)
    end

    def crossover(chs1, chs2)
        send(@crossover_method, chs1, chs2)
    end

    def set_fitness_eval(&block)
        @fitness = block
    end

    def survive(population)
        population.each { |e| e.fitness = @fitness.call e }
        send(@survive_method, population)
    end

    def best
        best_idx = 0
        best_fit = nil
        @population.each_index do |idx|
            ch = @population[idx]
            ch.fitness = @fitness.call ch
            best_fit = ch.fitness if best_fit==nil
            best_idx = idx if best_fit < ch.fitness
            best_fit = ch.fitness if best_fit < ch.fitness
        end
        return @population[best_idx]
    end

    def avg
        avg_fit = 0
        @population.each do |ch|
            avg_fit += ch.fitness
        end
        return avg_fit/@population.size
    end
    
end

class Population < Array
    def initialize(size, chs_type, chs_len, chs_mutation, chs_prob)
        return if size==nil
        size.times do |i|
            self << Chromosome.new(chs_type, chs_len, chs_mutation, chs_prob)
        end
    end
end

class Chromosome < Array
    attr_accessor :fitness
    include ChromosomeType
    include MutationMethods

    def initialize(type, size, mutation, probability)
        @size = size
        self.send(type)
        @mutation_method = mutation
        @mutation_probability = probability
    end

    def mutate!
        if rand(100)<=probability
            self.send(:mutation_method)
        end
    end
end