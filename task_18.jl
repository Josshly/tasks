
function task_18(r, side)
    tolim(r, side)
end

function tolim(r, side)
    if !isborder(r, side)
        move!(r, side)
        tolim(r, side)
    end
end