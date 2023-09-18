/*

__________ ____ ___  _____________  __.___.____    .____     
\______   \    |   \/   _____/    |/ _|   |    |   |    |    
 |    |  _/    |   /\_____  \|      < |   |    |   |    |    
 |    |   \    |  / /        \    |  \|   |    |___|    |___ 
 |_______ /______/ /_______  / ___|__ \___|_______ \_______ \
                              \/     \/           \/       \/
                                                  \/       \/                  

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

magnet_position_x=3;
magnet_position_z=18;
magnet_position_y=4;
magnet_distance=16.5;

//breakaway magnet

//USB_port variables
u_h = 14.2;
u_w = 13.5;
u_d = 5.7;

//pogo variables

pogo_length=7.6;
pogo_diameter=2.6; //+.3 +.2 +.2 +.2
pogo_distance=.1; //distance between pins 
shift=2; //distance from pins 
shift2=2; //distance from top

//receptor variables

//breakaway variables
i_h = 22; //x
i_w = 8; //z
i_d = 20; //y

//release variables
i_l_h =i_h; //x
i_l_w = i_w; //z
i_l_d = 20; //y

//pogo pins

module pogos(){
    translate([-.7,0,4.2]){
        translate([shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+pogo_diameter+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
            translate([(pogo_distance+pogo_diameter)*2+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([(pogo_distance+pogo_diameter)*3+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}
}

//pogos();

module usb(){
    color("grey",.1)translate([-1,3.8,0])cube(size = [u_h,u_w,u_d],center=false);
}

//usb();
//pogo receptors

module recs(){

}

//recs();

module magnet(){
   color("grey") rotate ([90,0,0])translate([magnet_position_x,magnet_position_y,magnet_position_z])cylinder($fn = 30, $fa = 30, $fs = 2, h=4, r1=2.15, r2=2.15, center = true);
    
   color("grey") rotate ([90,0,0])translate([magnet_position_x+magnet_distance,magnet_position_y,magnet_position_z])cylinder($fn = 30, $fa = 30, $fs = 2, h=4, r1=2.15, r2=2.15, center = true);
    

}

//magnet();

//

x=.;
module void(){
usb();
    translate([x,0,0])pogos();

}

 //void();


module void2(){
translate([30,-1.7,.3])pogos();

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
    magnet();
   // release_block();

block_distance=25;    
        module breakaway_block(){
    color("Pink",.55)
 rotate([90,0,0]){
            translate([block_distance,0,0]){
                cube(size = [i_h, i_w, 2], center = false);
            }
        } 
    translate([30-x,0,3])cube(size = [12,2,3], center=false);
        } 
  //breakaway_block();

    
difference(){
       release_block();
    translate([5,-i_l_d+3,0])void();


}

 //translate([5,-i_l_d+3,0])void();

module assemble(){
translate([0,0,0])difference(){
      breakaway_block();
    void2();
   
}
}

assemble();



