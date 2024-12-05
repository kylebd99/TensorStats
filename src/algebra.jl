# This file manages the logic of algebraic properties. For the moment, we just spoof Finch's
# properties, but in the future we can extend these or write our own.

function isassociative(f)
    if f == choose(false)
        return true
    end
    return Finch.isassociative(Finch.DefaultAlgebra(), f)
end

function iscommutative(f)
    if f == choose(false)
        return true
    end
    return Finch.iscommutative(Finch.DefaultAlgebra(), f)
end

function isunarynull(f)
    return f in (max, min, *, +)
end

function isdistributive(f, g)
#    distributes = Finch.isdistributive(Finch.DefaultAlgebra(), f, g)
    distributes = ((f == +) && ((g == max) || (g == min)))
    distributes = distributes || ((f == choose(false)) && (g == |))
    distributes = distributes || ((f == |) && (g == choose(false)))
    distributes = distributes || ((f == &) && (g == choose(false)))
    distributes = distributes || ((f == &) && (g == |))
    distributes = distributes || ((f == *) && (g == +))
    return distributes
end


function cansplitpush(f, g)
    if !ismissing(repeat_operator(f)) && f == g && iscommutative(f) && isassociative(f)
        return true
    elseif (f == choose(false)) && (g == |)
        return true
    end
    return false
end

# If there exists a g such that f(x_,...{n times},...x) = g(x, n),
# then return g.
function repeat_operator(f)
    if isidempotent(f)
        return nothing
    elseif f == +
        return *
    elseif f == *
        return exp
    else
        return missing
    end
end

function isidentity(f, x)
    return Finch.isidentity(Finch.DefaultAlgebra(), f, x)
end

function isannihilator(f, x)
    return Finch.isannihilator(Finch.DefaultAlgebra(), f, x)
end

function isidempotent(f)
    return Finch.isidempotent(Finch.DefaultAlgebra(), f)
end

function is_binary(f)
    return (f == |) || (f == &)
end
