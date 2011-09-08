global_settings {
    charset            ascii
    adc_bailout        1/255
    ambient_light      <1.0, 1.0, 1.0>
    assumed_gamma      1.3
    hf_gray_16         off
    irid_wavelength    <0.25,0.18,0.14>
    max_trace_level    5
    max_intersections  64
    number_of_waves    10
    noise_generator    2

    radiosity {
        adc_bailout      0.01
        always_sample    on
        brightness       1.0
        count            35  // (max = 1600)
        error_bound      1.8
        gray_threshold   0.0
        low_error_factor 0.5
        max_sample       30
        minimum_reuse    0.015
        nearest_count    5  // (max = 20)
        normal           off
        pretrace_start   0.08
        pretrace_end     0.04
        recursion_limit  3
     }
}

#declare LLength=1.5;
#declare LPath=
spline {
	cubic_spline
	-1, <150, 100, 0>
	0, <100 , 100 , 0>
	0.5, <50 , 100 , 0 >
	1, <100 , 100 , -50 >
	1.5, <100,100,-100>
	2, <100,100,-150>
}

#declare zoom=0.15;
camera {
    orthographic
    location  <0.0, 0.0 ,-10.0>
    direction z 
    right image_width/image_height*x/zoom
    up y/zoom
	look_at 0
    sky <0.0, 1.0, 0.0>
	translate -1.9*x
    rotate 45*x
    rotate 45*y
}

light_source {
    LPath(clock*LLength), rgb 1 
}

// create a block
#macro Block(level,centre,sz)
		box {centre+<+sz,+sz,+sz>,centre+<-sz,-sz,-sz>}
	#if (level>0)
		#local level2=level-1;
		#local sz2=sz/3;
		Block (level2,centre+<+sz,+sz,+sz>,sz2)
		Block (level2,centre+<+sz,+sz,-sz>,sz2)
		Block (level2,centre+<+sz,-sz,+sz>,sz2)
		Block (level2,centre+<+sz,-sz,-sz>,sz2)
		Block (level2,centre+<-sz,+sz,+sz>,sz2)
		Block (level2,centre+<-sz,+sz,-sz>,sz2)
		Block (level2,centre+<-sz,-sz,+sz>,sz2)
		Block (level2,centre+<-sz,-sz,-sz>,sz2)
	#end
#end

union {
	Block(6,<0,0,0>,1)
	pigment { color rgb <1,0.9,0.8> }
}

plane {
	y, -1.500
	pigment {bumps
		color_map {
			[0.0 rgb <1,0.3,0.1>]
			[0.99 rgb <1,1,0.3>]
		}
	}
}

