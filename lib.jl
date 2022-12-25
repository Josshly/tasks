using HorizonSideRobots;
include("border_functions.jl")
include("robots.jl")

function inverse_side(side)
    return (HorizonSide((Int(side) + 2) % 4))
end

function clockwise_side(side)
    return (HorizonSide((Int(side) + 3) % 4))
end

function counterclockwise_side(side)
    return (HorizonSide((Int(side) + 1) % 4))
end

try_move!(r, side) = (!isborder(r, side) && (move!(r, side); return true); false)

function spiral_move!(r, side::HorizonSide, steps::Int64)
    for _ in 1:steps
        if ismarker(r)
            return
        end
        move!(r, side)
    end
end

function spiral_move!(stop_condition::Function, r, side::HorizonSide, steps::Int64)
    for _ in 1:steps
        if stop_condition()
            return
        end
        move!(r, side)
    end
end

function move_if_markers!(r, side::HorizonSide)
    while ismarker(r)
        move!(r, side)
    end
end

function along!(r, side::HorizonSide; markers=false)
    way_back = [(Nord, 0)]
    steps = 0
    if markers
        putmarker!(r)
    end
    while !isborder(r, side)
        move!(r, side)
        steps += 1
        if markers
            putmarker!(r)
        end
    end
    push!(way_back, (inverse_side(side), steps))
    return way_back
end

function along!(stop_condition::Function, r, side::HorizonSide)
    while !stop_condition(side) && try_move!(r, side)

    end
end

function along!(stop_condition::Function, r, side::HorizonSide, max_num_steps::Int)
    num_steps = 0
    while num_steps < max_num_steps && !stop_condition() && try_move!(r, side)
        num_steps += 1
    end
    return nun_steps
end

function along!(r, side::HorizonSide, steps::Int)
    n = 0
    while n < steps
        move!(r, side)
        n += 1
    end
end

function snake!(r; move_side=Ost, next_row_side=Nord, markers=false)
    while !isborder(r, next_row_side)
        along!(r, move_side; markers)
        move!(r, next_row_side)
        move_side = inverse_side(move_side)
    end
    along!(r, move_side; markers)
end

function snake!(stop_condition::Function, r; move_side=Ost, next_row_side=Nord)
    along!(stop_condition, r, move_side)
    while !stop_condition(move_side) && try_move!(robot, next_row_side)
        move_side = inverse_side(move_side)
        along!(stop_condition, r, move_side)
    end
end

function spiral!(r)
    side = Nord
    steps = 1
    while !ismarker(r)
        for _ in 1:2
            spiral_move!(r, side, steps)
            side = clockwise_side(side)
        end
        steps += 1
    end
end

function spiral!(stop_condition::Function, r)
    side = Nord
    steps = 1
    while !stop_condition()
        for _ in 1:2
            spiral_move!(stop_condition, r, side, steps)
            side = clockwise_side(side)
        end
        steps += 1
    end
end

function shuttle!(r)
    side = West
    while isborder(r, Nord)
        putmarker!(r)
        move_if_markers!(r, side)
        side = inverse_side(side)
    end
end

function shuttle!(stop_condition::Function, r, side::HorizonSide)
    steps = 0
    while !stop_condition()
        steps += 1
        along!(r, side, steps)
        side = inverse_side(side)
    end
end