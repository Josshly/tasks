include("lib.jl")

function task_2(r)
    path = move_to_west_south_corner!(r)

    for i in (Ost, Nord, West, Sud)
        along!(r, i; markers=true)
    end
    putmarker!(r)
    move_by_path!(r, path)
end
