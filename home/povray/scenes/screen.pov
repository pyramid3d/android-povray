#include "colors.inc"
#include "metals.inc"
#include "textures.inc"

// ---------------------------------------------------------------------------
// Object Settings
// ---------------------------------------------------------------------------
//Vega Strike Colors
//font color = #483855
//glow color = #BFB8FE
//#declare COLOR_PANEL = rgb <0.7490, 0.7216, 0.9961>;
//#declare COLOR_PANEL = rgb <0.2824, 0.2196, 0.3333>;
#declare COLOR_PANEL = rgb <0.000, 0.000, 0.000>;
#declare TRANSPARENCY = 0.9;
#declare ROUNDING = 0.05;
#declare SPECULARITY = 0.01;
#declare CENTER_HIGHLIGHT = false;

// ---------------------------------------------------------------------------
// Global Settings
// ---------------------------------------------------------------------------
global_settings {
  assumed_gamma 1        
  ambient_light <1,1,1>
  //photons {
  //  spacing 0.1 //0.01
  //  media 1 //60
  //}
}

// ---------------------------------------------------------------------------
// Camera and Lights
// ---------------------------------------------------------------------------
#declare camera_distance = 20;
camera {                        
  location <0,0,camera_distance>
  right x up y direction -z
  angle 180*atan(2/camera_distance)/pi
  // Uncomment to render a side view  
  //rotate 50*x
}

light_source { <-30,70,100>, <1,1,1>
  //photons { reflection off refraction off }
  //media_interaction off
}  

// ---------------------------------------------------------------------------
// Objects
// ---------------------------------------------------------------------------

// Rounded square button
#declare b_rsquare = superellipsoid {
  // Adjust first parameter: 1=circle, 0=square
  //<0.1 + 0.05*frame_number,0.3>
  <ROUNDING, 0.3>
  translate -z scale <1,1,0.1>
}

// Button symbol (start/stop)
#declare c_start = merge {
  difference {
    cylinder { <0,0,0>,<0,0,1>,1 }
    union {
      cylinder { <0,0,-1>,<0,0,2>,0.7 }
      box { <-0.3,0,-1>,<0.3,2,2> }
    }
  }
  box { <-0.15,0.2,0>,<0.15,1.2,1> }
}

// Button texture
#declare t_button = texture {
  finish {
    ambient 0.9 //0.2
    diffuse 0.0 // 0.9
    specular 0
    phong 0.05 phong_size 0.01 //0.6 20
    reflection 0
  }
  //normal { bumps 0.05 scale 0.01 }
  pigment { color COLOR_PANEL transmit TRANSPARENCY }
}

// Button and contents (hole in button for backlight)
#declare final_button = difference {
  object { b_rsquare scale 1.0 }
  //object { c_start scale <0.5,0.5,2> translate <0,0,-1> }
}

// Backlight
/*light_source {
  <0,0,-20>, White
  projected_through { box { <-0.7,-0.7,-1.1>,<0.7,0.7,-1> } }
  photons {
    reflection on
    refraction on
  }
  media_interaction on
}*/

// ---------------------------------------------------------------------------
// Scene
// ---------------------------------------------------------------------------

// Button
object { final_button texture { t_button }
  #if(CENTER_HIGHLIGHT)
    photons {
        target
        collect on
        reflection on
        refraction on
    }
  #end
}

// Media container
#if(CENTER_HIGHLIGHT)
    cylinder { <0,0,0.01>,<0,0,1>,5
    hollow pigment { color rgbt 1 }
    interior { media {
        scattering { 2,White*0.7 }
        density { spherical scale 2
        density_map {
            // Outside
            [0 rgb 0] [0.55 rgb 0]
            // Inside and center
            [0.65 rgb 1] [1 rgb 1]
        }
    } } }
    photons {
        target
        collect on
        reflection on
        refraction on
    }
    }
#end

// EOF
