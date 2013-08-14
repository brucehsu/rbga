module MutationMethods
    def swap
        idx1 = rand(self.size)
        idx2 = rand(self.size)
        while idx1==idx2
            idx2 = rand(self.size)
        end
        self[idx1], self[idx2] = self[idx2], self[idx1]
    end

    def inversion
        head = self.size/4
        tail = self.size*3/4
        while head<=tail
            self[head], self[tail] = self[tail], self[head]
            head+=1
            tail-=1
        end
    end
end