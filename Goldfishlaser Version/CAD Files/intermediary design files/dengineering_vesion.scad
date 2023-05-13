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

The "release" is connected to a USB extension cord that terminates with the female USB port that receives a USB.  It contains 4 pogo pins directly soldered to the female usb port and 1 oval magnet. It separates from the release when the cord is pulled. (red)

The "breakaway" is connected to the cord that terminates with the male USB and inserts the computer. It contains 4 pins terminating in pogo receptors and 1 round  magnet and a plastic case. (pink)

When the magnets on the breakaway and release connect, the pogo pins and pogo receptors must meet and establish the USB connection.

The breakaway and release plugs must be designed asymmetrically to prevent the connection from happening the wrong way. 

In this version I have borrowed these mangets and pogo receptors from the Supplier verison of the BusKill cable.

docs.buskill.in
buskill.in
*/



//magnet variables

//release magnet

m_h=4.5 //magnet height
m_w= 12.8//magnet width
m_t= .8//magnet thickness
im_h=2.3 // inner magnet height


//breakaway magnet

//USB_port variables
u_h = 12;
u_w = 13.5;
u_d = 5.7;

//pogo variables

pogo_length=7.6;
pogo_diameter=1.5;
pogo_distance=.9; //distance between pins 
shift=2; //distance from pins 

//receptor variables

//breakaway variables
i_h = 22; //x
i_w = 8; //z
i_d = 18; //y

//release variables
i_l_h =i_h; //x
i_l_w = i_w; //z
i_l_d = 18; //y

//pogo pins

module pogos(){
    translate([0,0,4.5]){
        translate([shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+pogo_diameter+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
            translate([(pogo_distance+pogo_diameter)*2+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([(pogo_distance+pogo_diameter)*3+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}
}

//pogos();

module usb(){
    cube(size = [u_h,u_w,u_d],center=false);
}

//usb();
//pogo receptors

module recs(){

}

//recs();

module magnet(){
    
}

//magnet();

//

module void(){
usb();
    pogos();
    magnet();
}

 //void();
    translate([5,-i_l_d+3,1])void();

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
    translate([5,-i_l_d+5,3])void();


}

translate([0,0,0])difference(){
      base_block();
    translate([3+block_distance,-i_d,3])void2();
    translate([3+block_distance,-i_d,9])void2();
    translate([4+block_distance,-15,3]);
}




