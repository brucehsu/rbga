module CrossoverMethods
    def order_crossover(chs1, chs2)
        idx = rand(chs1.size/2)
        new_chs1 = Chromosome.new(@chromosome_type, chs1.size, @mutation_method, @mutation_probability)
        new_chs1.clear
        new_chs1 << chs1[idx..(idx+chs1.size/2)]
        new_chs1.flatten!
        new_chs2 = Chromosome.new(@chromosome_type, chs1.size, @mutation_method, @mutation_probability)
        new_chs2.clear
        new_chs2 << chs2[idx..(idx+chs2.size/2)]
        new_chs2.flatten!

        chs1.size.times do |i|
            unless new_chs1.include? chs2[i]
                if new_chs1.size<=(chs1.size*3/4)
                    new_chs1.insert(0,chs2[i])
                else
                    new_chs1.push(chs2[i])
                end
            end
        end

        chs2.size.times do |i|
            unless new_chs2.include? chs1[i]
                if new_chs2.size<=(chs2.size*3/4)
                    new_chs2.insert(0,chs1[i])
                else
                    new_chs2.push(chs1[i])
                end
            end
        end

        return [new_chs1, new_chs2]
    end
end