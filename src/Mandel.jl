
module Mandel

import Images
import Reel

include("escape.jl")
include("color.jl")
include("config.jl")
include("grid.jl")

fractus(cfg) = (
	imRange(cfg["bl"], cfg["resw"], cfg["resh"], cfg["w"])
		.|> escapeTimeWith(cfg["func"], cfg["iters"])
		.|> cfg["color"](cfg["iters"])
		 |> transpose
		 |> f -> reverse(f, dims=1)
		 |> f -> Images.save(string("out/img/", cfg["name"]), f)
)

fractusNoSave(cfg) = (
	imRange(cfg["bl"], cfg["resw"], cfg["resh"], cfg["w"])
		.|> escapeTimeWith(cfg["func"], cfg["iters"])
		.|> cfg["color"](cfg["iters"])
		 |> transpose
		 |> f -> reverse(f, dims=1)
)

import Reel

fractus(cfg1, cfg2, duration, fps) = begin
	frames = fps*duration
	cfgPara = parameterizeConfigByFrame(cfg1, cfg2, frames)

	frame = 1
	render(t, dt) = begin
		# println("Starting frame ", frame)
		data = fractusNoSave(cfgPara(frame))
		frame += 1
		data
	end

	film = Reel.roll(render, fps=fps, duration=frames/fps)

	println("Done with frames...")
	write("out/vid/test.webm", film)
end

export fractus

end # module
