
import Images

# The most basic of coloring functions...
# All coloring functions should have this type.
monocolor(iters) = n -> (n == iters + 1
	? Images.RGBA(0, 0, 0, 1)  # It's captured. Black it is.
	: Images.RGBA(1, 1, 1, 1)) # It escaped! Color it white.

# A version which accepts a function to color
# escaped points only. Captured points are black.
# Returns the wrapped coloring function.
capturedToBlack(escapeColorFunc) = iters -> n -> (n == iters + 1
	? Images.RGBA(0, 0, 0, 1)
	: Images.RGBA((escapeColorFunc(n) .|> Images.clamp01nan)...))

# Setup for a phased color loop, a not very descriptive name
# for a color scheme that uses various sin functions to map
# into the unit range.

# For each RGB channel, we need a frequency, phase, and minimum
# (in the unit range).
# We need one such set for channel, so we require a dict, with
# keys R, G, and B, which map to a 3 tuple.
phasedColorLoop(config) = begin
    snr = (f, p, m) -> x -> sin(f*x + p)*0.5*(1 - m) + 1 + m
    f = x -> [
    	snr(config["R"]...)(x)
    	snr(config["B"]...)(x)
    	snr(config["G"]...)(x)
    	1]

    capturedToBlack(f)
end

const BASIC_PCL = Dict(
	"R" => (0.016, 4, 0.1),
	"G" => (0.13, 2, 0.1),
	"B" => (0.01, 1, 0.1),
)

export phasedColorLoop, capturedToBlack
