module SurviveMethods
    def min_fitness(population)
        population.sort! { |a, b| a.fitness <=> b.fitness }
        @population = population[0..(@population.size-1)]
    end

    def max_fitness(population)
        population.sort! { |a, b| b.fitness <=> a.fitness }
        @population = population[0..(@population.size-1)]
    end
end