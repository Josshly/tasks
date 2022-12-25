include("lib.jl")

function task_16(r)
    spiral!(() -> ismarker(r), r)
end