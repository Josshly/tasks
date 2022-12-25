include("lib.jl")

function task_1(r)
    for i in (Nord, Sud, Ost, West)
        path = along!(r, i; markers=true)
        move_by_path!(r, path)
    end
    putmarker!(r)
end