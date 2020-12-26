
const BASIC_FCONFIG = Dict(
	"bl" => -2 -1im,
	"w" => 3.0,

	"resw" => 2100,
	"resh" => 1400,

	"iters" => 1000,
	"func" => (z, c) -> z^2 + c,

	"color" => phasedColorLoop(BASIC_PCL),
	"name" => "fractal.bmp",
)

const TEST_FCONFIG = Dict(
	"bl" => -0.49054109031733145 + 0.5296658986175117im,
	"w" => 0.25,

	"resw" => 800,
	"resh" => 400,

	"iters" => 1000,
	"func" => (z, c) -> z^2 + c,

	"color" => phasedColorLoop(BASIC_PCL),
	"name" => "test2.bmp",
)

export BASIC_FCONFIG
export TEST_FCONFIG

# Config Parametrics

parameterizeConfigByFrame(cfg1, cfg2, frames) = begin
	# The parameterization must scale with width as it
	# continues, or else the percieved zoom level will
	# accelerate as the gif continues.

	wΔ = cfg2["w"] - cfg1["w"]
	# wPara(frame) = cfg1["w"] + (frame/frames)*wΔ

	# 0 -> 1 into 1 -> e
	# f = x -> ex + 1

	# 1 -> e into 0 -> wΔ
	# g = x -> ln(x)*wΔ

	# 0 -> wΔ into w1 -> w2
	# h = x -> w1 + x

	# thus:
	# 0 -> 1 into 0 -> wΔ, logarithmically:
	# h = g(f(x)) = x -> x |> f |> g

	f = x -> (ℯ-1)*x + 1
	gw = x -> log(x)*wΔ
	hw = x -> cfg1["w"] + x

	wPara = frame -> (frame/frames) |> f |> gw |> hw

	blΔ = cfg2["bl"] - cfg1["bl"]
	# blPara(frame) = cfg1["bl"] + (frame/frames)*blΔ # linear is no good

	gbl = x -> log(x)*blΔ
	hbl = x -> cfg1["bl"] + x

	blPara = frame -> (frame/frames) |> f |> gbl |> hbl

	cfg_frame = copy(cfg1)
	cfgPara(frame) = begin
		println(string(frame*100/frames, "%"))
		cfg_frame["bl"] = blPara(frame)
		cfg_frame["w"] = wPara(frame)

		# How to calculate the iters...
		# Maybe leave that up to the caller...
		cfg_frame
	end
end

export parameterizeConfigByFrame
