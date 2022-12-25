function task_23(array::Vector{T}) where T
    summa(array)
end


function summa(array::Vector{T}, s::T=0) where T
    if length(array) == 0
        return s
    end
    return summa((array[1:end-1]), s+array[end])
end