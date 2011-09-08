all: koch3d.png

%.png : %.pov %.ini
	povray $*.ini
