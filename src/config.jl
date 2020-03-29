
const BASIC_FCONFIG = Dict(
	"bl" => -3 -1im,
	"w" => 4.0,

	"resw" => 1400,
	"resh" => 700,

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
    blΔ = cfg2["bl"] - cfg1["bl"]
    blPara(frame) = cfg1["bl"] + (frame/frames)*blΔ

    wΔ = cfg2["w"] - cfg1["w"]
    wPara(frame) = cfg1["w"] + (frame/frames)*wΔ

    cfg_frame = copy(cfg1)
    cfgPara(frame) = begin
        cfg_frame["bl"] = blPara(frame)
        cfg_frame["w"] = wPara(frame)

        # How to calculate the iters...
        # Maybe leave that up to the caller...
   		cfg_frame
    end
end

export parameterizeConfigByFrame
