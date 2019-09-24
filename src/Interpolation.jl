module Interpolation

export polyint

"""    polyint(xs, ys[, n])

Returns a function that performs polynomial interpolation across the `xs` and
`ys`.

`n`, if given, is the order of the interpolating polynomial; if the length of
the `xs` and `ys` is greater than `n+1`, then multiple interpolants are
returned.
"""
function polyint(xs, ys)
    n = length(xs)
    polyint(xs, ys, n-1)
end

function polyint(xs::Array{T, 1}, ys::Array{T, 1}, n) where T
    triangle = Array{T,1}[ys]
    for i in 2:n+1
        push!(triangle, zeros(T, length(triangle[i-1])-1))
    end

    full =  n == length(xs)-1

    function interpolate(x)
        for i in 2:n+1
            k = length(triangle[i])
            for j in 1:k
                triangle[i][j] = (x-xs[j+i-1])*triangle[i-1][j]/(xs[j]-xs[j+i-1]) + (x-xs[j])*triangle[i-1][j+1]/(xs[j+i-1]-xs[j])
            end
        end

        if full
            triangle[end][1]
        else
            Tuple(triangle[end])
        end
    end
end

end # module
