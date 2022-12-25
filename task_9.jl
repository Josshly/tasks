include("lib.jl")

function task_9(r)
    path = move_to_west_south_corner!(r)
    is_marker = true
    side = Ost
    while !(isborder(r, Nord) && isborder(r, side))
        if is_marker
            putmarker!(r)
        end
        if !isborder(r, side)
            move!(r, side)
            is_marker = !is_marker
        end
        if !isborder(r, Nord) && isborder(r, side)
            if is_marker
                putmarker!(r)
            end
            move!(r, Nord)
            is_marker = !is_marker
            side = inverse_side(side)
        end
    end
    if is_marker
        putmarker!(r)
    end
    move_to_west_south_corner!(r)
    move_by_path!(r, path)
end