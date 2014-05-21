def add num1, num2
  num1 + num2
end

def subtract num1, num2
  num1 - num2
end

def sum ary
  sum = 0
  ary.each do |num|
    sum += num
  end
  sum
end

def multiply *nums
  total = 1
  nums.each do |num|
    total *= num
  end
  total
end

def power num1, num2
    num1 ** num2
end

def factorial num
    total = 1
    while num > 0
        total *= num
        num -= 1
    end
    total
end
