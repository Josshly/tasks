include("lib.jl")

function task_20(r, side)
    step!(r, side)
end

function step!(r, side)
    if !isborder(r, side)
        move!(r, side)
    else
        move!(r, counterclockwise_side(side))
        step!(r, side)
        move!(r, clockwise_side(side))
    end
end