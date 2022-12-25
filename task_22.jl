include("lib.jl")

function task_22(r, side)
    to_symm_poss(r, side)
end

function to_symm_poss(r, side)
    if isborder(r, side)
        tolim(r, inverse_side(side))
    else
        move!(r, side)
        to_symm_pos(r, side)
        move!(r, side)
    end
end

function tolim(r, side)
    if !isborder(r, side)
        move!(r, side)
        tolim(r, side)
    end
end