/*

__________ ____ ___  _____________  __.___.____    .____     
\______   \    |   \/   _____/    |/ _|   |    |   |    |    
 |    |  _/    |   /\_____  \|      < |   |    |   |    |    
 |    |   \    |  / /        \    |  \|   |    |___|    |___ 
 |_______ /______/ /_______  / ___|__ \___|_______ \_______ \
                              \/     \/           \/       \/
                                                  \/       \/   usbamagb_v03               

*/
/*                      
Buskill USB-A Magnetic breakaway Shell Assembly     
GNU General Public License v3.0 
Author: Melanie Allen
*/
    

/*
Description

BusKill is a Dead Man Switch triggered when a magnetic breakaway is tripped, severing a USB connection. This code creates a 3D printable file for plastic parts needed to create the magnetic breakaway. 

To assemble a BusKill Dead Man Switch cord you will need: a usb-a extension cord, a usb hard drive capable of being attached to a caribiner, a caribiner, the plastic pieces in this file, a usb female port, a usb male, 4 magnets, 4 pogo pins, 4 pogo receptors, wire, 8 screws, and BusKill software. For full BOM, glossary, and assembly instructions, see the files in the repo.

The magnetic breakway consists of a "breakaway" (blue) and a "release" (red). When the magnets on the breakaway and release connect, the pogo pins and pogo receptors meet and establish the USB connection. When the parts are separated, the USB connection is severed.

The "breakaway" consists of three plastic pieces. The enclosure, the lid, and the face. The face contains areas for two 1/8" cube magnets and pogo receptors. The enclosure allows for the housing of a wire jig, wires and female usb port. The lid screws onto the enclosure with 4 x 1.5-2M screws. 

The "release" consists of three plastic parts. The enclosure, the lid, and the face. The face contains areas for two 1/8" cube magnets and pogo pins. The enclosure allows for the housing of a wire jig, wires, and male usb. The release plugs into the computer. The lid screws onto the enclosure with 4 x 1.5-2M screws.

"Jigs" serve purposes such as housing wires and holding hardware in place during assembly and use. (yellow)

The code in this file is divided into five section: Parameters, Hardware, Breakaway, Release, and Assembly.
Parameters: Should you need to adjust this design to suit the parts available to you, you can tune variables for parts in this section 
Hardware: This section contains modules related to creating areas for magnets, usb, pogo pins, pogo receptors, and jigs. 
Breakaway: This section contains modules related to creating enclosure (lid, body, and face) for the breakaway. 
Release: This section contains modules related to creating the enclosure (lid, body, and face) for the release.
Assembly: This section allows you to call the modules individually or all at once. 

If you're new to openscad, might be helpful to know that numbers representing dimensions are in "mm" units. 

The assembly of the BusKill cord is as follows: (1) attach the caribiner to the usb (2) insert the USB hard drive into the female usb port in the assembled "breakaway" (3) connect the magnets of the "breakaway" to the "release" (4) insert the male usb from the "release" into the female port of the extension cable (5) insert the male end of the usb cable into the computers usb-a port. 


docs.buskill.in
buskill.in
*/

//acknowledgements to BaldGuyDIY for enclosure code

/*********** PARAMETERS ***********/

//magnet parameters 
magnet_position_x=3;
magnet_position_z=18.1;
magnet_position_y=4;
magnet_distance=23; //distance between magnets
magnet_size=3.175; // for 1/8" cube magnet
magnet_tolerance= .2; //to allow room for press fit


//USB male parameters 
u_h = 16; //height
u_w = 13; //width
u_d = 4.7; //depth 

//USB female parameters
u_f_h = 16; //height
u_f_w = 14.5; //width
u_f_d = 5.7; //depth 


//pogo parameters

pogo_length=7.6;
pogo_diameter=2.8; // pogo thickness
pogo_distance=1.5; //distance between pins 
shift=2.1; //distance from pins 
spread=4.8;
shift2=2; //distance from top

// pogo receptor parameters
size_difference = .9; // right now the code just uses pogo pin code scaled down by this variable

//jig slot variables

js_w=18;
js_h=8;
js_l=4.5;


/*********** HARDWARE ***********/

//pogo pins

module pogos(){
    translate([-.7,-.1,4.2]){
        translate([shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+spread,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
            translate([pogo_distance+spread*2,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+spread*3,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}
}

//pogos();

// pogo receptors 

module pogo_recs(){
    translate([-.7,-.1,4.2]){
        translate([shift,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+spread,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
            translate([pogo_distance+spread*2,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+spread*3,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}
}

//pogo_recs();

//usb male
module usb(){
    color("grey",.1)translate([-1,4.5,0])cube(size = [u_h,u_w,u_d],center=false);
}

//usb();

//usb female
module usb_p(){
    color("grey",.1)translate([-1,3.8,0])cube(size = [u_f_h,u_f_w,u_f_d],center=false);
}

//usb_p();


/** cube magnet **/
module magnet(){
color("grey") rotate ([90,0,0])translate([magnet_position_x,magnet_position_y,magnet_position_z])cube(magnet_size+magnet_tolerance, center=true);
    
   color("grey") rotate ([90,0,0])translate([magnet_position_x+magnet_distance,magnet_position_y,magnet_position_z])cube(magnet_size+magnet_tolerance,center=true);
    

}

//magnet();

/** disc magnet **/ 
module disc_magnet(){
color("grey") rotate ([90,0,0])translate([magnet_position_x,magnet_position_y,magnet_position_z])cylinder($fn = 30, $fa = 30, $fs = 2, h=4, r1=2.15+magnet_tolerance, r2=2.15+magnet_tolerance, center = true);
    
   color("grey") rotate ([90,0,0])translate([magnet_position_x+magnet_distance,magnet_position_y,magnet_position_z])cylinder($fn = 30, $fa = 30, $fs = 2, h=4, r1=2.15, r2=2.15, center = true);  

}

//disc_magnet();


// wire jigs
module jig(){
 j_d=20; //distance between jigs
    
    difference(){
        cube(size = [17,7,2],center=false);
        translate([0,3.5,-2])pogos();
    }
    
    translate([0,j_d,0])
    difference(){
        cube(size = [17,7,2],center=false);
        translate([0,3.5,-2])pogos();
    }
   
}
//jig();

/**
//this commented out code was used to create a wire jig that curves wire from the place where it comes out of face to where it could be soldered to a usb female or male. it didn't work well for me, but keeping the code in case it helps others or I change my mind. 

    module pogojig(){
    pj_h=5; //height top
    pj_h2=6.75; //height back
    pj_s=3; //shift forward top
    pj_s2=-1; //shift forward back
    pj_t=30; //tilt left
    pj_t2=-pj_t; //tilt right
  pj_t3=10; //tilt left innie
    pj_t4=-pj_t3; //tilt right innie
    pj_ts=1.25; // shift back left
    pj_ts2=-pj_ts; // shift back right
    
    
    pogo_diameter=2;
    shift=2.25;
    translate([-.7,-.1,3]){
        translate([shift,pj_s,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pj_h, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true); //1st from right 
    translate([pogo_distance+spread,pj_s,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pj_h, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true); // 2nd from right
            translate([pogo_distance+spread*2,pj_s,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pj_h, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true); //3rd from right
    translate([pogo_distance+spread*3,pj_s,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pj_h, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}

    translate([-.7,-.1,3]){
        translate([shift+pj_ts,pj_s2,0])rotate ([90,0,pj_t])cylinder($fn = 30, $fa = 30, $fs = 2, h=pj_h2, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true); //1st from right 
    translate([pogo_distance+spread,pj_s2,0])rotate ([90,0,pj_t3])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pj_h2, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true); // 2nd from right
            translate([pogo_distance+spread*2,pj_s2,0])rotate ([90,0,pj_t4])cylinder($fn = 30, $fa = 30, $fs = 2, h=pj_h2, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true); //3rd from right
    translate([pogo_distance+spread*3+pj_ts2,pj_s2,0])rotate ([90,0,pj_t2])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pj_h2, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}

}

//pogojig();
**/

  /*
  //this commented out code is for a small retangular piece with holes the size of pogos. at one time it was thought this piece might help with stabilization but it didn't really pan out. 
  
     module jig2(){
 
         translate ([0,-10,0])rotate([90,0,0]){difference(){
     cube(size = [pogo_house_x+innie_tolerance,pogo_house_y*.25+innie_tolerance,pogo_house_z+innie_tolerance], center=false);
     
      translate([0,0,-2])pogos();
     }
 }
 }
     jig2();

 translate([-25,0,0])jig2();
   */  


/*********** RELEASE ***********/

//RELEASE FACE

//variables
i_l_h =28; //width
i_l_w = 8; //height
i_l_d = 3; //length

r_extrusion_x=5;//extrusion x
r_extrusion_y=1; //extrusion y
r_extrusion_z=8;//extrusion z

x=.75;
y=.5;

/** version with cube magnets **/

 module release_void(){
translate([30+x,y,0])pogo_recs();
translate([24.5,17.5,0])magnet();
}
//release_void();   

/** version with disc magnets **/
 module release_void_m(){
translate([30+x,y,0])pogo_recs();
translate([24.5,17+1,0])disc_magnet();
}
//release_void_m();   


//pogo house is the extrusion on the front of the release face. the breakaway face has a coresponding admission allowing for mating.
pogo_house_x = 17.5;
pogo_house_y = 2;
pogo_house_z =4;
pogo_house_pos_x= 31.75;
pogo_house_pos_y= 0;
pogo_house_pos_z= 2.25;


block_distance=25;    
        module release_face(){
    color("red",.55)
 rotate([90,0,0]){
            translate([block_distance+1.5,0,0]){
                cube(size = [i_l_h, i_l_w, i_l_d], center = false);
            }
        } 
    color("red",.55)translate([pogo_house_pos_x,pogo_house_pos_y,pogo_house_pos_z])cube(size = [pogo_house_x,pogo_house_y,pogo_house_z], center=false);
                           color("red",.55)translate([26.5,0,0]) cube(size = [r_extrusion_x, r_extrusion_y, r_extrusion_z], center = false);   
        color("red",.55)translate([26.5+magnet_distance,0,0])cube(size = [r_extrusion_x, r_extrusion_y, r_extrusion_z], center = false);
        } 
  //release_face();
        
module make_r_face(){
 translate([0,5.75,3]) rotate([90,0,0])difference(){
      release_face();
    translate([shiftxx,0,0])release_void();
   
}

// translate([0,5.75,3]) translate([shiftxx,0,0])rotate([90,0,0])release_void();

}        
// make_r_face();

module make_r_face_m(){
 translate([0,5.75,3]) rotate([90,0,0])difference(){
      release_face();
    translate([shiftxx,0,0])release_void_m();
   
}

} 

//make_r_face_m();
 
// RELEASE ENCLOSURE

 
 module enclosure_r(){

     
    $fn=15;
  //dimensions for enclosure_r
  e_w=24;
  e_l=28;  
  e_h=8;   
     

     
 //parameters
     corner_r = .5; //higher is more rounded
     wall_thicc = 1.5; 
     post_d = 2.5; //support post for screw hole
     hole_d= 1.5; //hole for screws
     lid_thicc = 1; 
     lid_lip = .5; //inset
     lid_tol = .5;
     
     module posts(x,y,z,h,r){
         
         translate([x,y,z]){
             cylinder(r = r, h = h);
         }
     
              translate([-x,y-3,z]){
             cylinder(r = r, h = h);
         }
         
                  translate([-x,-y+3,z]){
             cylinder(r = r, h = h);
         }
                 translate([x,-y,z]){
             cylinder(r = r, h = h);
         }
     }
     difference(){
         //box
     hull(){
     posts(
         x=e_w/2 - corner_r, 
         y=e_l/2 - corner_r, 
         z=0, 
         h=e_h,
         r=corner_r);
     }
     //hollow
         hull(){
     posts(
             x=e_w/2 - corner_r - wall_thicc, 
         y=e_l/2 - corner_r - wall_thicc, 
         z=wall_thicc, 
         h=e_h,
         r=corner_r);
     }
     //lip
       hull(){
     posts(
           x=e_w/2 - corner_r - lid_lip, 
         y=e_l/2 - corner_r - lid_lip, 
         z=e_h-lid_thicc, 
         h=lid_thicc + 1,
         r=corner_r);
     }
     //usb
     translate([-14,-11,1])usb(); 
     //pogos
      //translate([12,-8,1])rotate([0,0,90])pogo_recs();
     //slot
     translate([11,0,4])cube([js_h,js_w,js_l], true); //jig slot
 }


 difference(){
    //support posts
     posts(
     x=e_w/2 - wall_thicc/2 - post_d/2 -.5, 
         y=e_l/2 - wall_thicc/2 - post_d/2-.5, 
         z=wall_thicc-.5, 
         h=e_h - wall_thicc - lid_thicc +.5,
         r=post_d/2);
    
     
    //screw holes    
     posts(
     x=e_w/2 - wall_thicc/2 - post_d/2-.5, 
         y=e_l/2 - wall_thicc/2 - post_d/2-.5, 
         z=wall_thicc, 
         h=e_h - wall_thicc - lid_thicc +.5,
         r=hole_d/2);    
 }
 

translate([40,0,-e_h-4]){
difference(){
//lid
  hull(){
     posts(
      x=e_w/2 - corner_r - wall_thicc/2 - lid_tol, 
         y=e_l/2 - corner_r - wall_thicc/2 - lid_tol, 
         z=e_h - lid_thicc +5, 
         h=lid_thicc,
         r=corner_r);
     }
     
     //holes in lid

     posts(
     x=e_w/2 - wall_thicc/2 - post_d/2 -.5, 
         y=e_l/2 - wall_thicc/2 - post_d/2 -.5, 
         z=wall_thicc, 
         h=e_h - wall_thicc - lid_thicc +10,
         r=hole_d/2);      
 }
 }
 
 }; //end of enclosure_r code
 
module make_enclosure_r(){
color("red",.9)translate([40,-20,0]) rotate([0,0,90]) enclosure_r();
 //add logo
color("black") linear_extrude(2)translate([48,14.25,0])scale(1.5)rotate([0,0,90])import("Bus.svg"); //option where logo is split
 //color("black")translate([45,11,0])scale(.8)rotate([0,0,90])linear_extrude(2)import("buskill_wordsonly.svg"); //option where logo is not split
}
//make_enclosure_r();


/*********** BREAKAWAY ***********/

 //BREAKAWAY FACE
 
 //variables
i_x = i_l_h; //base width
i_z = 10; //base height
i_y = 2.2; //base length

b_extrusion_x=5;//extrusion x
b_extrusion_y=1.5; //extrusion y
b_extrusion_z=8;//extrusion z


innie_tolerance=.5;         
     
 face_distance=26.5;  //distance from release face
        module breakaway(){
    color("blue",.55)
 translate([25,.2,0])
            rotate([90,0,0]){
            translate([face_distance,-.75,2]){
                cube(size = [i_x, i_z, i_y], center = false);

            }
                           translate([face_distance,0,2]) rotate([-90,0,0]) cube(size = [b_extrusion_x, b_extrusion_y, b_extrusion_z], center = false);   
        translate([face_distance+magnet_distance,0,2])rotate([-90,0,0])cube(size = [b_extrusion_x, b_extrusion_y, b_extrusion_z], center = false);
           translate([face_distance,.25,.5])cube(size = [i_x, b_extrusion_y, b_extrusion_y], center = false);
            translate([face_distance,6.75,.5])cube(size = [i_x, b_extrusion_y, b_extrusion_y], center = false);
        } 
        
        }   

//breakaway();
     
 pogo_house2_pos_x= pogo_house_pos_x+23.5;
 pogo_house2_pos_y= pogo_house_pos_y-b_extrusion_y;
 pogo_house2_pos_z= pogo_house_pos_z;  

/** version with cube magnets **/
        
 module breakaway_void(){
     translate([pogo_house2_pos_x-(innie_tolerance),pogo_house2_pos_y,pogo_house2_pos_z-(innie_tolerance)])cube(size = [pogo_house_x+innie_tolerance+.25,pogo_house_y+innie_tolerance,pogo_house_z+innie_tolerance+.5], center=false);
     
     translate([55.5,-2.6,0])pogo_recs(); //smaller than pogos
     translate([49.5,17.6,0])magnet();
    // translate([49.5,17.6,0])magnet();
     }    
        
//breakaway_void(); 

/**version with disc magnets **/
     
 module breakaway_void_m(){
     translate([pogo_house2_pos_x-(innie_tolerance*.5),pogo_house2_pos_y,pogo_house2_pos_z-(innie_tolerance*.5)])cube(size = [pogo_house_x+innie_tolerance,pogo_house_y+innie_tolerance,pogo_house_z+innie_tolerance], center=false);
     
     translate([55.5,-2.6,0])pogo_recs(); //smaller than pogos
     translate([49.5,18.5,0])disc_magnet();
     translate([49.5,18,0])disc_magnet();
     }    
        
//breakaway_void_m();      
       
 
     shiftxx=1.5;
     shiftyy=-1.45;
 module make_b_face(){
 translate([10,5.75,4]) rotate([90,0,0])
     difference(){
 breakaway();
 translate([shiftxx,shiftyy,0])breakaway_void();
 }    
 }
 
 //translate([10,5.75,4]) rotate([90,0,0]) translate([shiftxx,shiftyy,0])breakaway_void();
// make_b_face();
 
 module make_b_face_m(){
 translate([10,5.75,3.5]) rotate([90,0,0])
     difference(){
 breakaway();
 translate([shiftxx,shiftyy,0])breakaway_void_m();
 }    
 }
//make_b_face_m();

// BREAKAWAY ENCLOSURE


module enclosure_b(){
     
     
    $fn=15;
  //dimensions for enclosure_b
  e_w=30;
  e_l=26;  
  e_h=9;   
     
     
 //parameters
     corner_r = .5; //higher is more rounded
     wall_thicc = 1.5; 
     post_d = 2.5; //support post for screw hole
     hole_d= 1.5; //hole for screws
     lid_thicc = 1; 
     lid_lip = .5; //inset
     lid_tol = .5;
    
     
     module posts(x,y,z,h,r){
         
         translate([x,y,z]){
             cylinder(r = r, h = h);
         }
     
              translate([-x,y-2.5,z]){
             cylinder(r = r, h = h);
         }
         
                  translate([-x,-y+2.5,z]){
             cylinder(r = r, h = h);
         }
                 translate([x,-y,z]){
             cylinder(r = r, h = h);
         }
     }
     difference(){
         //box
     hull(){
     posts(
         x=e_w/2 - corner_r, 
         y=e_l/2 - corner_r, 
         z=0, 
         h=e_h+1,
         r=corner_r);
     }
     //hollow
         hull(){
     posts(
             x=e_w/2 - corner_r - wall_thicc, 
         y=e_l/2 - corner_r - wall_thicc, 
         z=wall_thicc, 
         h=e_h +1,
         r=corner_r);
     }
     //lip
       hull(){
     posts(
           x=e_w/2 - corner_r - lid_lip, 
         y=e_l/2 - corner_r - lid_lip, 
         z=e_h-lid_thicc, 
         h=lid_thicc +1,
         r=corner_r);
     }
     //usb
     translate([-14,-11,2])usb_p(); 
     //jig slot
      translate([11,0,5])cube([js_h,js_w,js_l],true); 
     //translate([12,-8,1])rotate([0,0,90])pogo_recs();  //pogos
 }

 

 difference(){
    //support posts
     posts(
     x=e_w/2 - wall_thicc/2 - post_d/2-.5, 
         y=e_l/2 - wall_thicc/2 - post_d/2-.5, 
         z=wall_thicc-.5, 
         h=e_h - wall_thicc - lid_thicc +1,
         r=post_d/2);
    
     
    //screw holes    
     posts(
     x=e_w/2 - wall_thicc/2 -  post_d/2-.5, 
         y=e_l/2 - wall_thicc/2 - post_d/2-.5, 
         z=wall_thicc-.5, 
         h=e_h - wall_thicc - lid_thicc +1,
         r=hole_d/2);    
 }


translate([45,0,-e_h+1]){
difference(){
//lid
  hull(){
     posts(
      x=e_w/2 - corner_r - wall_thicc/2 - lid_tol, 
         y=e_l/2 - corner_r - wall_thicc/2 - lid_tol, 
         z=e_h - lid_thicc, 
         h=wall_thicc - lid_thicc +1,
         r=corner_r);
     }
     
     //holes in lid
 posts(
     x=e_w/2 - wall_thicc/2 - post_d/2-.5, 
         y=e_l/2 - wall_thicc/2 - post_d/2-.5, 
         z=e_h - lid_thicc, 
         h=wall_thicc - lid_thicc + 1,
         r=hole_d/2);     
 }
 }
 

 }; //end of enclosure_b code

module make_enclosure_b(){
color("blue",.9)translate([75,-20,0]) rotate([0,0,90]) enclosure_b();
color("black") translate([80,4.75,.5])linear_extrude(2)rotate([0,0,90])scale(1.5)import("kill.svg"); //for use with split logo option
 
// translate([shiftxx+10,shiftyy,0])breakaway_void();
}

//make_enclosure_b();
    
/*********** ASSEMBLY ***********/
 
 //comment or uncomment below to render desired parts
 
/** all **/
module make_all(){
 make_r_face();
 make_enclosure_r();  
 make_b_face();
 make_enclosure_b();
 jig();  
 translate ([-25,0,0])jig();   
} 

make_all();

/** only release **/
module only_r()
{
    translate([0,0,0])make_enclosure_r();
   translate([0,0,0]) jig();
    }

//only_r();
    
/** only breakaway **/

module only_b()
{
    translate([0,0,0])make_enclosure_b();
   translate([0,0,0]) jig();
    }
//only_b();    
 
/** only wire jigs **/
    
module only_j()
{
    jig();
    translate ([-25,0,0])jig();
    }
//only_j();    

/** only release face **/
    
module only_r_f(){
make_r_face();
}
//only_r_f();

/** only breakaway face **/

module only_b_f(){
   translate([0,0,0]) make_b_face();
}
//make_b_face();

/** disc version of faces*/

module make_disc_version(){
   make_r_face_m();  
    make_b_face_m();
}
//make_disc_version();