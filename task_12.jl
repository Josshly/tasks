include("lib.jl")

function task_12(r)
    path = move_to_west_south_corner!(r; go_around_barriers=true)
    side = Ost
    count = 0
    gap = 0
    is_border = false
    while !isborder(r, Nord)
        while !isborder(r, side)
            count, gap, is_border = isborder_special(r, count, gap, Nord, is_border)
            move!(r, side)
        end
        count, gap, is_border = isborder_special(r, count, gap, Nord, is_border)
        side = inverse_side(side)
        move!(r, Nord)
    end
    move_to_west_south_corner!(r; go_around_barriers=true)
    move_by_path!(r, path)
    return count
end

function isborder_special(r, count::Int, gap::Int, side::HorizonSide, is_border::Bool)
    if isborder(r, side)
        gap = 0
        is_border = true
    end
    if !isborder(r, side) && is_border
        gap += 1
        if gap < 2
            is_border = true
        else
            is_border = false
            count += 1
        end
    end
    return count, gap, is_border
end