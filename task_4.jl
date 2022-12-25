include("lib.jl")

function task_4(r)
    for i in ((Nord, Ost), (Nord, West), (Sud, Ost), (Sud, West))
        steps = go_special(r, i)
        return_special(r, i, steps)
    end
    putmarker!(r)
end

function go_special(r, side::Tuple{HorizonSide,HorizonSide})
    num_steps = 0
    while !isborder(r, side[1]) && !isborder(r, side[2])
        move!(r, side[1])
        move!(r, side[2])
        putmarker!(r)
        num_steps += 1
    end
    return num_steps
end

function return_special(r, side::Tuple{HorizonSide,HorizonSide}, steps::Int64)
    num_steps = 0
    while num_steps < steps
        move!(r, inverse_side(side[1]))
        move!(r, inverse_side(side[2]))
        num_steps += 1
    end
end