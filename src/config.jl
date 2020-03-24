
const BASIC_FCONFIG = Dict(
	"bl" => -3 -1im,
	"w" => 4.0,

	"resw" => 1400,
	"resh" => 700,

	"iters" => 1000,
	"func" => (z, c) -> z^2 + c,

	"color" => phasedColorLoop(BASIC_PCL),
	"path" => "fractal.bmp",
)

const TEST_FCONFIG = Dict(
	"bl" => -0.49054109031733145 + 0.5296658986175117im,
	"w" => 0.25,

	"resw" => 800,
	"resh" => 400,

	"iters" => 1000,
	"func" => (z, c) -> z^2 + c,

	"color" => phasedColorLoop(BASIC_PCL),
	"path" => "test2.bmp",
)

export BASIC_FCONFIG
export TEST_FCONFIG
