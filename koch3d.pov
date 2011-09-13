#declare Radio=true;


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
    ambient_light      0

    #if(Radio)
        radiosity {
            adc_bailout      0.01
            always_sample    on
            brightness       2.0
            count            35  // (max = 1600)
            error_bound      1.8
            gray_threshold   0.4//0.0
            low_error_factor 0.5
            max_sample       30
            minimum_reuse    0.015
            nearest_count    10  // (max = 20)
            normal           off
            pretrace_start   0.08
            pretrace_end     0.004
            recursion_limit  10
        }
     #end
}

#declare Blue = rgb<0.1, 0.23, 0.3>;
sky_sphere {
    pigment {
        gradient y
        color_map {
            [0 Blue*0.02]
            [1 Blue*0.05]
        }
        scale 2
        translate -1
    }
}

#include "textures.inc"
#include "colors.inc"
#include "woods.inc"

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

#declare zoom=0.158;

//#declare zoom=0.11;
camera {
    orthographic
    location  <0.0, 0.0 ,-10.0>
    right image_width/image_height*x/zoom
    up y/zoom
    look_at <0,-1.5,0>
    sky <0.0, 1.0, 0.0>
    translate -1.5*x
    rotate 28*x
    rotate 57*y
    translate 1.2*y
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

//box {
//	<-6,-1.500,-3>, <3, -3, 6>

//table
union {
    //tabletop
    union {
        cylinder {
            <0, 1, 0>, <0, -1, 0>, 3
            scale 0.2*y
        }
        torus {
            3, 0.2
        }

        scale 1.618*x
        translate -1.5*y-0.2*y
        texture {
            T_Wood11
            rotate 90*z
            rotate -92*y
        }
    }////*/
    // leg
    object {
        cylinder {
            <0, -1.5-0.2*2, 0>, <0,-10, 0>, 1.3
        }
        texture {
            T_Wood11
            rotate 92*x
            translate -1.5 * x
            rotate 45*y
        }
    }

    translate -1.5 * x
    rotate 45*y

}

// floor

plane {
    y, -4
    texture {
        pigment {
            checker Blue*0.0, Blue*0.02
            scale 1.5
        }
    }
}//*/


// kochka
union {
	//Block(6,<0,0,0>,1)
	Block(6,<0,0,0>,1)
	texture {
            //White_Marble
            T_Wood34
        }
        translate 1.5/4*(x-z)
}


