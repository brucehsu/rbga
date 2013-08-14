module ChromosomeType
    def permutation
        @size.times {|i| self << i }
        shuffle!
    end
end