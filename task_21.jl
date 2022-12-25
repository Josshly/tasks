include("lib.jl")

function task_21(r, side)
    doubledist(r, side)
end

function doubledist(r, side)
    if !isborder(r, side)
        move!(r, side)
        doubledist(r, side)
    else
        return
    end
    side = inverse_side(side)
    for _ in 1:2
        if !isborder(r, side)
            move!(r, side)
        else
            return false
        end
    end
    return true
end