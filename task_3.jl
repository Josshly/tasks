include("lib.jl")

function task_3(r)
    path = move_to_west_south_corner!(r)

    snake!(r; markers=true)

    move_to_west_south_corner!(r)
    move_by_path!(r, path)
end

