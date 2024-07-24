/*

__________ ____ ___  _____________  __.___.____    .____     
\______   \    |   \/   _____/    |/ _|   |    |   |    |    
 |    |  _/    |   /\_____  \|      < |   |    |   |    |    
 |    |   \    |  / /        \    |  \|   |    |___|    |___ 
 |_______ /______/ /_______  / ___|__ \___|_______ \_______ \
                              \/     \/           \/       \/
                                                  \/       \/   usbamagb_v04.0               

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
magnet_distance=20; //distance between magnets
magnet_size=3.175; // for 1/8" cube magnet
magnet_tolerance= .2; //to allow room for press fit

//r extrusion houses magnets on the release face
r_extrusion_x=4.75;//extrusion x
r_extrusion_y=1.75; //extrusion y
r_extrusion_z=8;//extrusion z


//USB male parameters 
u_h = 14; //height
u_w = 12; //width
u_d = 4.7; //depth 

//USB female parameters
u_f_h = 16; //height
u_f_w = 14.25; //width
u_f_d = 5.7; //depth 


//pogo parameters

pogo_length=7.6;
pogo_diameter=2.8; // pogo thickness
pogo_distance=1.5; //distance between pins 
shift=2.1; //distance from pins 
spread=4;
shift2=2; //distance from top

// pogo receptor parameters
size_difference = .7; // right now the code just uses pogo pin code scaled down by this variable

//jig slot variables

js_w=17.75;// 
js_h=8;
js_l=4.5;

//pogo house is the extrusion on the front of the breakaway face. the release face has a coresponding admission allowing for mating.
pogo_house_x = 15; //this is x
pogo_house_y = 2; // this is z
pogo_house_z =4; // this is y
pogo_house_pos_x= 31.75;
pogo_house_pos_y= 0;
pogo_house_pos_z= 2.25;

//pogo house 2 is the admission on the front of the release face. the breakaway has a corresponding extrusion allowing for mating

 pogo_house2_pos_x= pogo_house_pos_x+23.5;
 pogo_house2_pos_y= pogo_house_pos_y-r_extrusion_y-.25;
 pogo_house2_pos_z= pogo_house_pos_z;  

/*********** HARDWARE ***********/

//pogo pins

module pogos(){
    translate([-.3,.1,4.2]){
        
        translate([shift,0,0])
        rotate ([90,0,0])
        scale(.85)
        cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
        
        translate([pogo_distance+spread,0,0])
        rotate ([90,0,0])
        scale(.85)
        cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
            
        translate([pogo_distance+spread+spread-.5,0,0])
        rotate ([90,0,0])
        scale(.85)
        cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    
        translate([pogo_distance+spread*3-1,0,0])
        rotate ([90,0,0])
        scale(.85)
        cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
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
    color("grey",.1)translate([-1,5,0])cube(size = [u_h,u_w,u_d],center=false);
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

jig_w=17; //diff=2.5 to add room for slot
jig_h=2-.5;
jig_l=6.25;

slot_w=.75;
slot_h=jig_h/2;
slot_l=jig_l;

jigwall_w=slot_w;
jigwall_h=slot_h;
jigwall_l=jig_l-2;

var_w=1.25;
var_h=slot_h;
var_l=jig_l-2;

module var(){
    translate([spread+.4,0,var_h+.7])
    cube(size=[var_w,var_l,var_h], center=false);
    translate([spread+spread-.7+.5,0,var_h+.7])
    cube(size=[var_w,var_l,var_h], center=false);
     translate([spread+spread+spread-1.2+.5,0,var_h+.7])
    cube(size=[var_w,var_l,var_h], center=false);   
    
    }
 //   var();
    
    module var2(){
        translate([-25,0,0]){
    translate([spread-.1,0,var_h+.7])
    cube(size=[var_w,var_l,var_h], center=false);
    translate([spread+spread-.7,0,var_h+.7])
    cube(size=[var_w,var_l,var_h], center=false);
     translate([spread+spread+spread-1.2,0,var_h+.7])
    cube(size=[var_w,var_l,var_h], center=false);   
    
    }
}
//var2();

module slot(){translate([0,0,slot_h])cube(size=[slot_w,slot_l,slot_h], center=false);}

module jigwall(){translate([0,0,jigwall_h+.1])cube(size=[jigwall_w,jigwall_l,jigwall_h], center=false);} //change x to remove snap

module jig(){
 j_d=20; //distance between jigs
    translate([0,0,.7])slot();
        translate([jig_w-.75,0,.7])slot();
    difference(){
        cube(size = [jig_w,jig_l,jig_h],center=false);
        translate([1.5,3,-2.25])pogos();
    } //diff 1.5 to center 
    
    translate([0,j_d,0])
  
    difference(){
        cube(size = [jig_w,jig_l,jig_h],center=false);
        translate([1.5,3,-2.25])pogos();
        ;
    } 
    translate([.75,j_d,.6])jigwall(); //change x to remove snap
        translate([jig_w-1.5,j_d,.6])jigwall();
 
  var();

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

/**
  
     module jig2(){
       wire_d=2.25;
         spread2=4.5;
         module wire(){
              translate([3,.1,4.2]){
        
        translate([shift,0,0])
        rotate ([90,0,0])
        cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=wire_d/2, r2=wire_d/2, center = true);
        
        translate([pogo_distance+spread2-1,0,0])
        rotate ([90,0,0])
        cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=wire_d/2, r2=wire_d/2, center = true);
            
        translate([pogo_distance+spread2+spread2-2.5,0,0])
        rotate ([90,0,0])
        cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=wire_d/2, r2=wire_d/2, center = true);
    
        translate([pogo_distance+spread2*3-4,0,0])
        rotate ([90,0,0])
        cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=wire_d/2, r2=wire_d/2, center = true);
}

             }
 
         translate ([0,-10,0])rotate([90,0,0]){difference(){
     cube(size = [pogo_house_x-4+innie_tolerance,pogo_house_y*.5+innie_tolerance,pogo_house_z+innie_tolerance], center=false);
     
      translate([-2,0,-2])wire();
     }
 }
 }
**/ 
     //jig2();

// translate([-25,0,0])jig2();
  
   



/*********** RELEASE ***********/

 //RELEASE FACE
 
 //variables



innie_tolerance=.5;         
     
 face_distance=26.5;  //distance from release face

        module releasef(){
 i_x = i_l_h; //base width
i_z = 10-1.75; //base length diff=-2
i_y = 2.5; //base height diff=.3           
    color("red",.55)
 translate([25,.2,0])
            rotate([90,0,0]){
            translate([face_distance,0,2]){ // +1 to switch faces
                cube(size = [i_x, i_z, i_y], center = false);

            }
                           translate([face_distance,0,2]) 
            rotate([-90,0,0]) 
            cube(size = [r_extrusion_x, r_extrusion_y, r_extrusion_z], center = false);   
        
            translate([face_distance+magnet_distance+.25,0,2])rotate([-90,0,0])
            cube(size = [r_extrusion_x, r_extrusion_y, r_extrusion_z], center = false);
            
           translate([face_distance,0,.75])
            cube(size = [i_x, r_extrusion_y, r_extrusion_y], center = false); //rail2
            
            translate([face_distance,6.5,.75])
            cube(size = [i_x, r_extrusion_y, r_extrusion_y], center = false); //rail 1
        } 
        
        }   

//releasef();
    

        
 module release_void(){
     
     translate([pogo_house2_pos_x-(innie_tolerance),pogo_house2_pos_y,pogo_house2_pos_z-(innie_tolerance)])
     cube(size = [pogo_house_x+innie_tolerance+.25,pogo_house_y+innie_tolerance,pogo_house_z+innie_tolerance+.5], center=false);
     
     translate([55.5,-2.6,0])pogos(); //bigger than pogo 
     translate([49.5,17.6+.25,0])magnet();
    // translate([49.5,17.6,0])magnet();
     }    
      
//release_void(); 

       
 
     shiftxx=1.5;
     shiftyy=-1.45;
 module make_r_face(){
    
 translate([-25,5.75,4.3]) rotate([90,0,0])
     difference(){
 releasef();
 translate([shiftxx,shiftyy,0])release_void();
 }    
 }
 
 //make_r_face();
    

 
// RELEASE ENCLOSURE

 
 module enclosure_r(){

     
    $fn=15;
  //dimensions for enclosure_r
  e_w=24;
  e_l=25;  
  e_h=8;   
     
s_p=4; //make room for jig slot

     
 //parameters
     corner_r = .5; //higher is more rounded
     wall_thicc = 1.25; 
     post_d = 2.5; //support post for screw hole
     hole_d= 1.5; //hole for screws
     lid_thicc = .5; //lid_thicc<wall_thicc
     lid_lip = .25; //lid_lip < wall_thicc
     lid_tol = 1;
     taper=1; //makes backend smaller than front end
     inset=.75;//brings in posts so they dont end up on the edge of the lid
     
     module posts(x,y,z,h,r){
         
         translate([x,y,z]){
             cylinder(r = r, h = h);
         }
     
              translate([-x,y-taper,z]){
             cylinder(r = r, h = h);
         }
         
                  translate([-x,-y+taper,z]){
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
         h=lid_thicc,
         r=corner_r);
     }
     //usb
     translate([-14,-11,2])usb(); 
     //jig slot
      translate([11,0,4.5])cube([js_h,js_w,js_l],true); 
     //translate([12,-8,1])rotate([0,0,90])pogos();  //pogos
 }


 difference(){
    //support posts
    
     posts(
     x=e_w/2 - wall_thicc/2 - post_d/2 -inset, 
         y=e_l/2 - wall_thicc/2 - post_d/2 -inset, 
         z=wall_thicc, 
         h=e_h - wall_thicc - lid_thicc,
         r=post_d/2);
    
     
    //screw holes    
     posts(
     x=e_w/2 - wall_thicc/2 -  post_d/2 - inset, 
         y=e_l/2 - wall_thicc/2 - post_d/2 -inset, 
         z=wall_thicc, 
         h=e_h - wall_thicc - lid_thicc,
         r=hole_d/2);      
 
 }

translate([40,0,-e_h+.5]){
difference(){
//lid
  hull(){
     posts(
      x=e_w/2 - corner_r - wall_thicc/2 - lid_tol, 
         y=e_l/2 - corner_r - wall_thicc/2 - lid_tol, 
         z=e_h - lid_thicc, 
         h=wall_thicc - lid_thicc,
         r=corner_r);
     }
     
     //holes in lid
 posts(
     x=e_w/2 - wall_thicc/2 - post_d/2 - inset, 
         y=e_l/2 - wall_thicc/2 - post_d/2 -inset, 
         z=e_h - lid_thicc, 
         h=wall_thicc - lid_thicc,
         r=hole_d/2);     
 }
 
 
 }
 
 }; //end of enclosure_r code
 
module make_enclosure_r(){
color("red",.9)translate([40,-20,0]) rotate([0,0,90]) enclosure_r();
 //add logo
color("black") linear_extrude(2)translate([48,13,0])scale(1.5)rotate([0,0,90])import("Bus.svg"); //option where logo is split
 //color("black")translate([45,11,0])scale(.8)rotate([0,0,90])linear_extrude(2)import("buskill_wordsonly.svg"); //option where logo is not split
}
//make_enclosure_r();


/*********** BREAKAWAY ***********/
 

//BREAKAWAY FACE

//variables
i_l_h =25.25; //width
i_l_w = 10; //height 
i_l_d = 3.75; //length

b_extrusion_x=5;//extrusion x for magnet
b_extrusion_y=.1; //extrusion y for magnet
b_extrusion_z=8;//extrusion z for magnet
 
 module stopper(){
 stopper_x=i_l_h/3;
 stopper_y=1;
 stopper_z=8;
     
     level=3.75;

color("blue")
 translate([i_l_h+41.25,-6,i_l_d-level])
 cube(size = [stopper_x,stopper_y,stopper_z], center=false); //bottom slot
     
 color("blue")
 translate([i_l_h+48,i_l_w-6,i_l_d-level])     
 cube(size = [stopper_x,stopper_y,stopper_z], center=false); //top slot

color("blue")
 translate([i_l_h+35,-5,i_l_d-level])
 cube(size = [1,3,stopper_z], center=false); //left side slot     
     
color("blue")
 translate([i_l_h+62,2,i_l_d-level])
 cube(size = [1,3,stopper_z], center=false); //right side slot         
     
 }
 
 //stopper();
 
x=.75;
y=.5;

/** version with cube magnets **/

 module breakaway_void(){
translate([30+x,y-2,0])pogo_recs();
translate([24.5,16.5,0])magnet();
}
//breakaway_void();   


module breakaway_face(){



block_distance=25;    
        
    color("blue",.55)
 rotate([90,0,0]){
            translate([block_distance+1.25,0-1,0]){ //diff=-1 for switch
                cube(size = [i_l_h+1, i_l_w, i_l_d], center = false);
            }
        } 
    color("blue",.55)translate([pogo_house_pos_x,pogo_house_pos_y,pogo_house_pos_z])cube(size = [pogo_house_x,pogo_house_y-.5,pogo_house_z], center=false);
                           
        } 
  //breakaway_face();
        
module make_b_face(){
 translate([35,4,3.75]) rotate([90,0,0])difference(){
      breakaway_face();
    translate([shiftxx,0,0])breakaway_void();
  
}
stopper();
 // translate([0,5.75,3]) rotate([90,0,0])translate([shiftxx,0,0])breakaway_void();

}        
 //make_b_face();

module make_b_face_m(){
 translate([0,5.75,3]) rotate([90,0,0])difference(){
      breakaway_face();
    translate([shiftxx,0,0])breakaway_void_m();
   
}

} 

//make_b_face_m();

// BREAKAWAY ENCLOSURE


module enclosure_b(){
     
     
    $fn=15;
  //dimensions for enclosure_b
  e_w=26;
  e_l=26;  
  e_h=9;   
     
     
 //parameters
     corner_r = .5; //higher is more rounded
     wall_thicc = 1.25; 
     post_d = 2.5; //support post for screw hole
     hole_d= 1.5; //hole for screws
     lid_thicc = .5; //lid_thicc<wall_thicc
     lid_lip = .5; //lid_lip < wall_thicc
     lid_tol = 1;
    inset=.75;
    taper=1;
     
     module posts(x,y,z,h,r){
         
         translate([x,y,z]){
             cylinder(r = r, h = h);
         }
     
              translate([-x,y-taper,z]){
             cylinder(r = r, h = h);
         }
         
                  translate([-x,-y+taper,z]){
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
         h=lid_thicc,
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
     x=e_w/2 - wall_thicc/2 - post_d/2 -inset, 
         y=e_l/2 - wall_thicc/2 - post_d/2 - inset, 
         z=wall_thicc, 
         h=e_h - wall_thicc - lid_thicc,
         r=post_d/2);
    
     
    //screw holes    
     posts(
     x=e_w/2 - wall_thicc/2 -  post_d/2 - inset, 
         y=e_l/2 - wall_thicc/2 - post_d/2 -inset, 
         z=wall_thicc, 
         h=e_h - wall_thicc - lid_thicc,
         r=hole_d/2);    
 }


translate([45,0,-e_h+.5]){
difference(){
//lid
  hull(){
     posts(
      x=e_w/2 - corner_r - wall_thicc/2 - lid_tol, 
         y=e_l/2 - corner_r - wall_thicc/2 - lid_tol, 
         z=e_h - lid_thicc, 
         h=wall_thicc - lid_thicc,
         r=corner_r);
     }
     
     //holes in lid
 posts(
     x=e_w/2 - wall_thicc/2 - post_d/2 - inset, 
         y=e_l/2 - wall_thicc/2 - post_d/2 -inset, 
         z=e_h - lid_thicc, 
         h=wall_thicc - lid_thicc,
         r=hole_d/2);     
 }
 }
 

 }; //end of enclosure_b code

module make_enclosure_b(){
color("blue",.9)translate([75,-20,0]) rotate([0,0,90]) enclosure_b();
color("black") translate([80,2.5,.5])linear_extrude(2)rotate([0,0,90])scale(1.5)import("kill.svg"); //for use with split logo option
 

}

//make_enclosure_b();
    
/*********** ASSEMBLY ***********/
 
 //comment or uncomment below to render desired parts
 
/** all **/
module make_all(){
 translate([0,4,0]) make_b_face();
 make_enclosure_r();  
 make_r_face(); 
 make_enclosure_b();
 jig();  
 translate ([-25,0,0])jig();   
} 

make_all();

/** only release **/
module only_r()
{
    translate([0,0,0])make_enclosure_r();
    make_r_face();

    }

//only_r();
    
/** only breakaway **/

module only_b()
{
    translate([0,0,0])make_enclosure_b();
    make_b_face();

    }
//only_b();    
 
/** only wire jigs **/
    
module only_j()
{
    jig();
    translate ([-25,0,0])jig();
    jig2();
    translate([-25,0,0])jig2();
    }
//only_j();    

/** only release face **/
    
module only_r_f(){
 translate([0,0,0]) make_r_face();
}
//only_r_f();

/** only breakaway face **/

module only_b_f(){
    make_b_face();
  
}
//only_b_f();
