
# Creates a 2d grid of complex numbers from the given
# origin, width, and height. The resw and resh parameters
# determine the density of the mesh.
imRange(bl, resw, resh, w, h) = (x + y*1im for
	x in range(bl.re, bl.re + w, length = resw),
	y in range(bl.im, bl.im + h, length = resh))

# This version calculates the height for you.
imRange(bl, resw, resh, w) = imRange(bl, resw, resh, w, (resh/resw)*w)
