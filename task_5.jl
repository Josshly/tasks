include("lib.jl")
function task_5(r)
    path = move_to_west_south_corner!(r; go_around_barriers=true)
    side = Nord

    while side != "border"
        side = search!(r, side)
    end

    for i in (Nord, Ost, Sud, West, Nord)
        while isborder(r, clockwise_side(i))
            putmarker!(r)
            move!(r, i)
        end
        putmarker!(r)
        move!(r, clockwise_side(i))
    end

    move_to_west_south_corner!(r)
    for i in (Ost, Nord, West, Sud)
        along!(r, i; markers=true)
    end
    putmarker!(r)
    move_by_path!(r, path)
end

function search!(r, side::HorizonSide)
    while !isborder(r, side)
        (isborder(r, Ost)) ? break : move!(r, side)
    end
    if isborder(r, Ost)
        return_value = "border"
    else
        move!(r, Ost)
        return_value = inverse_side(side)
    end

    return return_value
end
