
escapeTimeWith(func, iters) = c -> begin
    z = c
    for i = 1:iters
    	if (z * conj(z)).re >= 4
    		return i
    	end

    	z = func(z, c)
    end
    return iters + 1
end

# Escape smoothing
# This can help produce more beautiful images, maybe.

smoothEscape(iters, z) = iters + log(abs(z))
