include("lib.jl")

function task_15(r)
    shuttle!(() -> !isborder(r, Nord), r, Ost)
end