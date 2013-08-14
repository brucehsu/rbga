module SelectionMethods
    def two_tournament
      idx1 = rand(@population.size)
      idx2 = rand(@population.size)
      while idx1==idx2
          idx2 = rand(@population.size)
      end
      @population[idx1].fitness = @fitness.call @population[idx1]
      @population[idx2].fitness = @fitness.call @population[idx2]
      return ((@population[idx1].fitness) < (@population[idx2].fitness)) ? idx1 : idx2  
    end
end