using HorizonSideRobots;

function go!(r, side::HorizonSide; steps::Int64=1, go_around_barriers::Bool=false, markers=false)::Int64
    way_back = 0
    if markers
        putmarker!(r)
    end
    if go_around_barriers
        path = move_around_barrier_steps!(r, side; steps, markers)
        way_back = get_num_of_steps_in_direction(path, side)
    else
        for i in 1:steps
            if markers
                putmarker!(r)
            end
            if !isborder(r, side)
                move!(r, side)
                way_back += 1
            else
                for i in 1:way_back
                    move!(r, inverse_side(side))
                end
                way_back = 0
                break
            end
        end
        if markers
            putmarker!(r)
        end
    end
    return way_back
end

function move_around_barrier_steps!(r, side::HorizonSide; steps::Int64=1, markers=false)::Array{Tuple{HorizonSide,Int64},1}
    way_back = [(Nord, 0)]
    steps_to_do = steps

    while steps_to_do > 0
        if markers
            putmarker!(r)
        end
        path = move_around_barrier!(r, side)
        for i in path
            push!(way_back, i)
        end
        steps_to_do -= get_num_of_steps_in_direction(path, side)
        if !isborder(r, side) && steps_to_do > 0
            push!(way_back, (inverse_side(side), 1))
            move!(r, side)
            steps_to_do -= 1
            if markers
                putmarker!(r)
            end
        end
        if markers && steps_to_do >= 0
            putmarker!(r)
        end
    end
    if steps_to_do < 0
        move_by_path!(r, way_back)
        way_back = [(Nord, 0)]
    end
    return way_back
end

function move_to_some_border!(r, side::HorizonSide; go_around_barriers::Bool=false, markers=false)::Array{Tuple{HorizonSide,Int64},1}
    way_back = [(Nord, 0)]
    if go_around_barriers
        steps = 0
        if markers
            putmarker!(r)
        end
        if !isborder(r, side)
            move!(r, side)
            steps = 1
            push!(way_back, (inverse_side(side), 1))
        else
            path = move_around_barrier!(r, side)
            steps = get_num_of_steps_in_direction(path, side)
            for i in path
                push!(way_back, i)
            end
        end
        if markers
            putmarker!(r)
        end
        while steps > 0
            if !isborder(r, side)
                move!(r, side)
                steps = 1
                push!(way_back, (inverse_side(side), 1))
                if markers
                    putmarker!(r)
                end
            else
                path = move_around_barrier!(r, side)
                steps = get_num_of_steps_in_direction(path, side)
                for i in path
                    push!(way_back, i)
                end
                if markers
                    putmarker!(r)
                end
            end
        end
    else
        steps = 0
        steps_now = go!(r, side; markers)
        while steps_now > 0
            steps += steps_now
            steps_now = go!(r, side; markers)
        end
        push!(way_back, (inverse_side(side), steps))
    end
    return way_back
end

function move_around_barrier!(r, side::HorizonSide)::Array{Tuple{HorizonSide,Int64},1}
    way_back = []
    parallel_side = clockwise_side(side)
    reverse_side = inverse_side(parallel_side)
    num_of_parallel_steps = 0
    num_of_direct_steps = 0

    if !isborder(r, side)
        way_back = [(Nord, 0)]
    else
        while isborder(r, side)
            if !isborder(r, parallel_side)
                move!(r, parallel_side)
                num_of_parallel_steps += 1
            else
                break
            end
        end
        if !isborder(r, side)
            move!(r, side)
            num_of_direct_steps += 1
            while isborder(r, reverse_side)
                num_of_direct_steps += 1
                move!(r, side)
            end
            push!(way_back, (inverse_side(parallel_side), num_of_parallel_steps))
            push!(way_back, (inverse_side(side), num_of_direct_steps))
            push!(way_back, (inverse_side(reverse_side), num_of_parallel_steps))
        else
            way_back = [(Nord, 0)]
        end
        while num_of_parallel_steps > 0
            num_of_parallel_steps -= 1
            move!(r, reverse_side)
        end
    end
    return way_back
end

function move_to_west_south_corner!(r; go_around_barriers::Bool=false, markers=false)::Array{Tuple{HorizonSide,Int64},1}
    way_back = []
    west_path = move_to_some_border!(r, West; go_around_barriers, markers)
    south_path = move_to_some_border!(r, Sud; go_around_barriers, markers)

    for i in west_path
        push!(way_back, i)
    end
    for i in south_path
        push!(way_back, i)
    end
    return way_back
end

function move_to_some_corner!(r, side_1::HorizonSide, side_2::HorizonSide; go_around_barriers::Bool=false, markers=false)::Array{Tuple{HorizonSide,Int64},1}
    way_back = []
    side1_path = move_to_some_border!(r, side_1; go_around_barriers, markers)
    side2_path = move_to_some_border!(r, side_2; go_around_barriers, markers)

    for i in side1_path
        push!(way_back, i)
    end
    for i in side2_path
        push!(way_back, i)
    end
    return way_back
end

function get_num_of_steps_in_direction(path::Array{Tuple{HorizonSide,Int64},1}, side::HorizonSide)::Int
    num_steps = 0
    for i in path
        (i[1] == side || i[1] == inverse_side(side)) ? num_steps += i[2] : Nothing
    end
    return num_steps
end

function move_by_path!(r, path::Array{Tuple{HorizonSide,Int64},1})
    new_path = reverse(path)
    for i in new_path
        go!(r, i[1]; steps=i[2])
    end
end
