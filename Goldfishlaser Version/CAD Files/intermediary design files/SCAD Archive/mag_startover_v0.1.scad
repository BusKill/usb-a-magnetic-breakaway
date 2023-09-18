/*

__________ ____ ___  _____________  __.___.____    .____     
\______   \    |   \/   _____/    |/ _|   |    |   |    |    
 |    |  _/    |   /\_____  \|      < |   |    |   |    |    
 |    |   \    |  / /        \    |  \|   |    |___|    |___ 
 |______  /______/ /_______  /____|__ \___|_______ \_______ \
        \/                 \/        \/           \/       \/


*/
/*                      
Buskill USB-A Magnetic breakaway Shell Assembly     
GNU General Public License v3.0 
Author: Melanie Allen
*/



/*
Description

BusKill is a Dead Man Switch triggered when a magnetic breakaway is tripped, severing a USB connection. This design is for USB-A.

The user will have a USB, a USB extension cable, and the magnetic breakaway. 

The "breakaway" is connected to a USB extension cord that terminates with the female USB port that receives a USB. It is in four parts, the base, two middle pieces, and the lid. It contains 5 pogo pins and 2 magnets. It separates from the release when the cord is pulled. (red)

The "release" is connected to the cord that terminates with the male USB and inserts the computer. It is in three parts, the base, the middle, and the lid. It contains 5 pogo receptors and 2 magnets. (pink)

When the magnets on the breakaway and release connect, the pogo pins and pogo receptors must meet and establish the USB connection.

The breakaway and release plugs must be designed asymmetrically to prevent the connection from happening the wrong way. 

The magnets are neodynium disc magnets 2x4mm.

docs.buskill.in
buskill.in
*/



//magnet variables
magnet_distance=16;

//breakaway variables
i_h = 22; //x
i_w = 13; //z
i_d = 18; //y

//release variables
i_l_h =i_h; //x
i_l_w = i_w; //z
i_l_d = 18; //y

//USB_port variables
u_h = 14;
u_w = 15;
u_d = 6;

//pogo variables

pogo_length=22;
pogo_diameter=2;
pogo_distance=5; //distance between pins (x=z)
shift=1; //distance from pins 

//receptor variables

rec_diameter=1.8;

//pogo pins

module pogos(){
        translate([shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter, r2=pogo_diameter-1, center = true);
    translate([pogo_distance+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter, r2=pogo_diameter-1, center = true);
}

//pogos();

//pogo receptors

module recs(){
        translate([shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=rec_diameter, r2=rec_diameter, center = true);
    translate([pogo_distance+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=rec_diameter, r2=rec_diameter, center = true);
}

//recs();

module magnets(){
   translate([0,2,0]) rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=4, r1=2.15, r2=2.15, center = true);
    
    translate([magnet_distance,2,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=4, r1=2.15, r2=2.15, center = true);
    
}

//magnets();

//

module void(){
    translate([4.5,pogo_length/2-2,0])pogos();
    magnets();
    
    
        translate([4.5,pogo_length/2-2,0])pogos();
    magnets();
}

//

module void2(){
    translate([4.5,pogo_length/2-2,0])recs();
    magnets();
    
    
        translate([4.5,pogo_length/2-2,0])recs();
    magnets();
}

 //translate([3,-i_l_d,3])void();
 //translate([3,-i_l_d,9])void();

/* * Blocks * */
    module top_block(){
    color("Red",.55)
 rotate([90,0,0]){
{
                cube(size = [i_l_h, i_l_w, i_l_d], center = false);
            }
        } 
    } 
   // top_block();

block_distance=25;    
        module base_block(){
    color("Pink",.55)
 rotate([90,0,0]){
            translate([block_distance,0,0]){
                cube(size = [i_h, i_w, i_d], center = false);
            }
        } 
    } 
  //base_block();

    
difference(){
       top_block();
    translate([3,-i_l_d,3])void();
    translate([3,-i_l_d,9])void();

}

translate([0,0,0])difference(){
      base_block();
    translate([3+block_distance,-i_d,3])void2();
    translate([3+block_distance,-i_d,9])void2();
    translate([4+block_distance,-15,3])
cube(size=[u_h,u_w,u_d], center = false);
}




