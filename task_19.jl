include("lib.jl")

function task_19(r, side)
    marklim!(r, side)
end

function marklim!(r, side)
    if isborder(r, side)
        putmarker!(r)
    else
        move!(r, side)
        marklim!(r, side)
        move!(r, inverse_side(side))
    end
end