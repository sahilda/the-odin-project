module Enumerable
    def my_each
        return self.to_enum unless block_given?
        for i in self
            yield i
        end
    end

    def my_each_with_index
        return self.to_enum unless block_given?
        idx = 0
        for i in self
            yield i, idx
            idx += 1
        end
    end

    def my_select
        return self.to_enum unless block_given?
        copy = self.dup
        for i in self
            if copy.class == Array
                copy.delete(i) unless yield i
            else
                copy.delete(i[0]) unless yield i
            end
        end
        return copy
    end

    def my_all?
        return self.to_enum unless block_given?
        for i in self
            return false unless yield i
        end
        return true
    end

    def my_any?
        return self.to_enum unless block_given?
        for i in self
            return true if yield i
        end
        return false
    end

    def my_none?
        return self.to_enum unless block_given?
        for i in self
            return false if yield i
        end
        return true
    end

    def my_count
        return self.to_enum unless block_given?
        counter = 0
        for i in self
            counter +=1 if yield i
        end
        return counter
    end

    def my_map(proc=nil)
        resp = []
        if block_given? && proc
            for i in self
                resp.push(proc.call(yield i))
            end
            return resp
        elsif proc
            for i in self
                resp.push(proc.call i)
            end
            return resp
        else
            return self.to_enum unless block_given?
            for i in self
                resp.push(yield i)
            end
            return resp
        end
    end

    def my_inject in1=nil, in2=nil
        return self.to_enum unless block_given? || in1 || in2
        if in1 == nil #no input
            initial = false
            for i in self
                if initial
                    initial = yield initial, i
                else
                    initial = i
                end
            end
        elsif in2 == nil #only 1 input
            if in1.class == Symbol # break out if symbol/not symbol
                # add case statements for treating operations, like +, -, /, *, etc
            else
                initial = in1
                for i in self
                    initial = yield initial, i
                end
            end
        else #two inputs
            initial = in1
            # add case statements for treating operations, like +, -, /, *, etc
            for i in self
                initial = yield initial, i
            end
        end
        return initial
    end
end

@a = ["a","bit city life","c","hold on tight","e","zzzz","hit me up"]
@b = {a: "bit city life",c: "hold on tight",p: "piratess"}

@a.my_each {|a| puts "#{a}"}
@a.each {|a| puts "#{a}"}
@b.my_each {|a,b| puts "#{a} #{b}"}
@b.each {|a,b| puts "#{a} #{b}"}

@a.my_each_with_index {|a,b| puts "#{a} #{b}"}
@a.each_with_index {|a,b| puts "#{a} #{b}"}
@b.my_each_with_index {|a,b| puts "#{a} #{b}"}
@b.each_with_index {|a,b| puts "#{a} #{b}"}

@a.my_select {|a| a[0] == 'h'}
@a.select {|a| a[0] == 'h'}
@b.my_select {|a,b| b[0] == 'h'}
@b.select {|a,b| b[0] == 'h'}

@a.my_all? {|a| a[0] == 'h'}
@a.all? {|a| a[0] == 'h'}
@b.my_all? {|a,b| a[0] == 'h'}
@b.all? {|a,b| a[0] == 'h'}

@a.my_any? {|a| a[0] == 'h'}
@a.any? {|a| a[0] == 'h'}
@b.my_any? {|a,b| b[0] == 'h'}
@b.any? {|a,b| b[0] == 'h'}

@a.my_none? {|a| a[0] == 'h'}
@a.none? {|a| a[0] == 'h'}
@b.my_none? {|a,b| a[0] == 'h'}
@b.none? {|a,b| a[0] == 'h'}

@a.my_count {|a| a[0] == 'h'}
@a.count {|a| a[0] == 'h'}
@b.my_count {|a,b| a[0] == 'h'}
@b.count {|a,b| a[0] == 'h'}

@a.my_map {|a| a[0] == 'h'}
@a.map {|a| a[0] == 'h'}
@b.my_map {|a,b| b[0] == 'h'}
@b.map {|a,b| b[0] == 'h'}

def multiply_els ary
    return ary.my_inject { |product, n| product * n }
end

multiply_els([2,4,5])
