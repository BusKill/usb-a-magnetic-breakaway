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

In this version I have borrowed these mangets and pogo receptors from the Supplier verison of the BusKill cable.

docs.buskill.in
buskill.in
*/



//magnet variables

//USB_port variables
u_h = 14;
u_w = 15;
u_d = 6;

//pogo variables

pogo_length=22;
pogo_diameter=2;
pogo_distance=5; //distance between pins 
shift=1; //distance from pins 

//receptor variables

//breakaway variables
i_h = 22; //x
i_w = 13; //z
i_d = 18; //y

//release variables
i_l_h =i_h; //x
i_l_w = i_w; //z
i_l_d = 18; //y

//pogo pins

module pogos(){
        translate([shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter, r2=pogo_diameter-1, center = true);
    translate([pogo_distance+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter, r2=pogo_diameter-1, center = true);
            translate([pogo_distance*2+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter, r2=pogo_diameter-1, center = true);
    translate([pogo_distance*3+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter, r2=pogo_diameter-1, center = true);
}

pogos();

//pogo receptors

module recs(){

}

//recs();

module magnet(){
    
}

//magnet();

//

module void(){

}

//

module void2(){

}


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




