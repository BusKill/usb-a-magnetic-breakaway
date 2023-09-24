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

BusKill is a Dead Man Switch triggered when a magnetic breakaway is tripped, severing a USB connection. This design is for USB-A.

The user will have a USB, a USB extension cable, and the magnetic breakaway. The user will attach a USB using a caribiner to their person. the USB will plug into the extension cable, which will plug into the magnetic breakaway usb female port. The magnetic breakaway usb male will insert into the computer.

The magnetic breakway consists of a "breakaway" and a "release". 

The "breakaway" consists of areas for two 1/8" cube magnets, a usb port, pogo receptors. The breakaway is connected to the cable attached to the person. (blue)

The "release" consists of areas for two 1/8" cube magnets, a usb, and pogo pins. The release plugs into the computer. (red)

"Jigs" serve purposes such as housing wires and holding hardware in place. (yellow)

When the magnets on the breakaway and release connect, the pogo pins and pogo receptors must meet and establish the USB connection.

The breakaway and release plugs must be designed asymmetrically to prevent the connection from happening the wrong way. 

docs.buskill.in
buskill.in
*/

//TODO: update design entirely yay



//magnet variables

//release magnet

magnet_position_x=3;
magnet_position_z=18.1;
magnet_position_y=4;
magnet_distance=23;

//breakaway magnet

//USB_port variables
u_h = 16;
u_w = 13.5;
u_d = 4.7;

//pogo variables

pogo_length=7.6;
pogo_diameter=2.6; //+.3 +.2 +.2 +.2
pogo_distance=1.5; //distance between pins 
shift=2.1; //distance from pins 
spread=4.8;
shift2=2; //distance from top

//receptor variables

//breakaway face variables
i_h = 28; //x
i_w = 8; //z
i_d = 20; //y

//release face variables
i_l_h =i_h; //x
i_l_w = i_w; //z
i_l_d = 20; //y

//jig slot variables

js_w=18;
js_h=8;
js_l=4.5;

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

/**
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
size_difference = .9;

module pogo_recs(){
    translate([-.7,-.1,4.2]){
        translate([shift,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+spread,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
            translate([pogo_distance+spread*2,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+spread*3,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}
}

//pogo_recs();

module usb(){
    color("grey",.1)translate([-1,3.8,0])cube(size = [u_h,u_w,u_d],center=false);
}

//usb();

module usb_p(){
    color("grey",.1)translate([-1,3.8,0])cube(size = [u_h,u_w+1,u_d+1],center=false);
}

//usb_p();


//pogo receptors

module recs(){

}

//recs();

magnet_size=3.175; 
magnet_tolerance= .2;


module magnet(){
color("grey") rotate ([90,0,0])translate([magnet_position_x,magnet_position_y,magnet_position_z])cube(magnet_size+magnet_tolerance, center=true);
    
   color("grey") rotate ([90,0,0])translate([magnet_position_x+magnet_distance,magnet_position_y,magnet_position_z])cube(magnet_size+magnet_tolerance,center=true);
    

}

//magnet();

//

x=.75;
y=.5;
module void(){

usb();
    translate([x,y,0])pogos();
translate([-5.5,17,0])magnet();
}

// void();


module void2(){
translate([30+x,y,0])pogo_recs();
translate([24.5,17+1,0])magnet();
}
//void2();

/* * Blocks * */

    module release_block(){
       
    color("Red",.55)
 rotate([90,0,0]){
{
                cube(size = [i_l_h, i_l_w, i_l_d], center = false);
            }
        } 
    } 
 
   // release_block();
    
    shiftx=5;
   module assemble3(){ 
    difference(){
       release_block();
    translate([shiftx,-i_l_d+3,0])void();


}

 //translate([shiftx,-i_l_d+3,0])void();
}

//RELEASE FACE

pogo_house_x = 17.5;
pogo_house_y = 2;
pogo_house_z =4;
pogo_house_pos_x= 31.75;
pogo_house_pos_y= 0;
pogo_house_pos_z= 2.25;


block_distance=25;    
        module release_block(){
    color("red",.55)
 rotate([90,0,0]){
            translate([block_distance+1.5,0,0]){
                cube(size = [i_h, i_w, 2], center = false);
                cube(size = [2, 2, 2], center = false);
            }
        } 
    translate([pogo_house_pos_x,pogo_house_pos_y,pogo_house_pos_z])cube(size = [pogo_house_x,pogo_house_y,pogo_house_z], center=false);

        } 
  //release_block();
        

  
 
 //BREAKAWAY FACE

innie_tolerance=.5;         
m_step=1.25;        
 block_distance2=25;    
        module breakaway(){
    color("blue",.55)
 translate([25,0,0])
            rotate([90,0,0]){
            translate([block_distance2+1.5,0,2]){
                cube(size = [i_h, i_w, 1.5], center = false);

            }
                           translate([26.5,0,2]) rotate([-90,0,0]) cube(size = [5, m_step+1, 8], center = false);   
        translate([25+magnet_distance+1.55,0,2])rotate([-90,0,0])cube(size = [5, m_step+1, 8], center = false);
        } 
        
        }   

//breakaway();
     
 pogo_house2_pos_x= pogo_house_pos_x+23.75;
 pogo_house2_pos_y= pogo_house_pos_y-m_step;
 pogo_house2_pos_z= pogo_house_pos_z;  
        
 module void3(){
     translate([pogo_house2_pos_x-(innie_tolerance*.5),pogo_house2_pos_y,pogo_house2_pos_z-(innie_tolerance*.5)])cube(size = [pogo_house_x+innie_tolerance,pogo_house_y+innie_tolerance,pogo_house_z+innie_tolerance], center=false);
     
     translate([55.5,-2.6,0])pogos();
     translate([49.5,18.5,0])magnet();
     translate([49.5,18,0])magnet();
     }    
        
//void3(); 
  
     module jig2(){
 
         translate ([0,-10,0])rotate([90,0,0]){difference(){
     cube(size = [pogo_house_x+innie_tolerance,pogo_house_y*.25+innie_tolerance,pogo_house_z+innie_tolerance], center=false);
     
      translate([0,0,-2])pogos();
     }
 }
 }
     jig2();
 translate([-25,0,0])jig2();
     
     shiftxx=1.5;
     shiftyy=-1.45;
 module assemble2(){
 difference(){
 breakaway();
 translate([shiftxx,shiftyy,0])void3();
 }    
 }
 translate([10,0,0])assemble2();
 
 // translate([10,0,0])translate([shiftxx,shiftyy,0])void3();
 
      //acknowledgements to BaldGuyDIY for enclosure code
 
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
     translate([11,0,4])cube([js_h,js_w,js_l], true);
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
 

color("red",.9)translate([40,-20,0]) rotate([0,0,90]) enclosure_r();
 //add logo
color("black") linear_extrude(2)translate([48,13,0])scale(1.5)rotate([0,0,90])import("Bus.svg");

// BREAKAWAY ENCLOSURE

module enclosure_b(){
     

     
    $fn=15;
  //dimensions for enclosure_b
  e_w=22;
  e_l=26;  
  e_h=8.2;   
     
     
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
     translate([-14,-11,1])usb_p(); 
     //jig
      translate([11,0,4])cube([js_h,js_w,js_l],true);
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

translate([40,0,-e_h]){
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
 
color("blue",.9)translate([75,-20,0]) rotate([0,0,90]) enclosure_b();
color("black") translate([68,-4,0])linear_extrude(2)mirror([0,1,0])rotate([0,0,270])scale(1.5)import("kill.svg");
 
// translate([shiftxx+10,shiftyy,0])void3();
    
module assemble(){
translate([0,0,0])difference(){
      release_block();
    translate([shiftxx,0,0])void2();
   
}
}

//translate([shiftxx,0,0])void2();

assemble();   

module jig(){
    
    difference(){

cube(size = [17,7,2],center=false);
        
        translate([0,3.5,-2])pogos();
    }
   

    }


jig();
   translate([0,20,0]) jig();