include("lib.jl")

function task_10(r::CoordRobot, N::Int)
    path = move_to_west_south_corner!(r)
    side = Ost

    while !(isborder(r, Nord) && isborder(r, side))
        putmarker_special!(r, N)
        if !isborder(r, Nord) && isborder(r, side)
            move!(r, Nord)
            putmarker_special!(r, N)
            side = inverse_side(side)
        end
        if !isborder(r, side)
            move!(r, side)
        end
    end

    putmarker_special!(r, N)

    move_to_west_south_corner!(r)
    move_by_path!(r, path)
end

function putmarker_special!(r::CoordRobot, N::Int)
 if ((r.coord.x % (N*2)) < N && (r.coord.y % (N*2)) < N) ||
    (((r.coord.x + N) % (N*2)) < N && (r.coord.y % (2 * N)) >= N)
        putmarker!(r)
    end
end
