include("lib.jl")

function task_6_a(r)
    path = move_to_west_south_corner!(r; go_around_barriers=true)
    for i in (Ost, Nord, West, Sud)
        along!(r, i; markers=true)
    end
    putmarker!(r)
    move_by_path!(r, path)
end

function task_6_b(r)
    for i in (Ost, Nord, West, Sud)
        path = move_to_some_border!(r, i; go_around_barriers=true)
        putmarker!(r)
        move_by_path!(r, path)
    end
end