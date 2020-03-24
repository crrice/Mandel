
module Mandel

include("escape.jl")
include("color.jl")
include("config.jl")
include("grid.jl")

fractus(cfg :: typeof(BASIC_FCONFIG)) = (
	imRange(cfg["bl"], cfg["resw"], cfg["resh"], cfg["w"])
		.|> escapeTimeWith(cfg["func"], cfg["iters"])
		.|> cfg["color"](cfg["iters"])
		 |> transpose
		 |> f -> reverse(f, dims=1)
		 |> f -> Images.save(string("./images/", cfg["name"]), f)
)

export fractus
end # module
