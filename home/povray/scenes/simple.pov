
object
{
	sphere { <0,1,0> 1 }
	texture { pigment { rgb <0.5,0.5,0.5> } }
}

object
{
	plane { <0,1,0> 0 }
	texture
	{ 
	    checker
	    texture {pigment { rgb <0.3,0.3,0.7> }},
	    texture {pigment { rgb <0.7,0.7,0.3> }}
	}
}

plane
{
	<0,1,0>,1 hollow // 
	texture
	{ 
	    pigment 
	    {
	        color rgb<0.1,0.3,0.75>*0.7
	    } 
	    #if (version = 3.7 ) finish {emission 1 diffuse 0} 
	    #else finish { ambient 1 diffuse 0} 
	    #end 
	} // end texture 1 
	texture
	{ 
	    pigment
	    { 
	        bozo turbulence 0.001 
	        octaves 6 omega 0.7 lambda 2 
	        color_map 
	        { 
	            [0.0 color rgb <0.95, 0.95, 0.95> ] 
	            [0.05 color rgb <1, 1, 1>*1.25 ] 
	            [0.15 color rgb <0.85, 0.85, 0.85> ] 
	            [0.55 color rgbt <1, 1, 1, 1>*1 ] 
	            [1.0 color rgbt <1, 1, 1, 1>*1 ] 
	        } // end color_map 
	        translate< 3, 0,-1> scale <0.3, 0.4, 0.2>*3 
	    } // end pigment 
	    #if (version = 3.7 ) finish {emission 1 diffuse 0} 
	    #else finish { ambient 1 diffuse 0} 
	    #end 
	} // end texture 2 
	scale 10000 
} //-------
text                                             
{
	ttf "crystal.ttf","povray",0.3,0
 texture { pigment { rgb <0.7,0.9,1.0> } }
	translate<-1.5,1.8,-1.5>
	scale < 0.78 , 0.8 , 0.8 > 
}


//fog
//{ 
//    fog_type 2 
//    distance 50 
//    color White 
//    fog_offset 0.1 
//    fog_alt 1.5 
//    turbulence 1.8 
//}

camera
{
	location <0,2,-3>
	look_at <0,1,0>
}
light_source
{
	<10,10,-4>
	color red 1 blue 1 green 1
}
