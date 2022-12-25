function cycle_fib(n::Integer)
    a = b = 1 
    while n > 0
        a, b = a + b, a
        n = n - 1
    end
    return b
end

function rec_fib(n::Integer)
    if n in (0,1)
        return 1
    end
    return rec_fib(n-2)+rec_fib(n-1)
end

function mem_fib(n)
    if n == 0
        return 1, 0
    else
        current, prev = mem_fib(n-1)
        return prev+current, current
    end
end