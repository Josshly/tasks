include("lib.jl")

function task_11(r)
    path = move_to_west_south_corner!(r; go_around_barriers=true)
    side = Ost
    count = 0
    is_border = false
    while !isborder(r, Nord)
        while !isborder(r, side)
            count, is_border = isborder_special(r, count, Nord, is_border)
            move!(r, side)
        end
        count, is_border = isborder_special(r, count, Nord, is_border)
        side = inverse_side(side)
        move!(r, Nord)
    end
    move_to_west_south_corner!(r; go_around_barriers=true)
    move_by_path!(r, path)
    return count
end

function isborder_special(r, count::Int, side::HorizonSide, is_border::Bool)
    if isborder(r, side)
        is_border = true
    end
    if !isborder(r, side) && is_border
        is_border = false
        count += 1
    end
    return count, is_border
end