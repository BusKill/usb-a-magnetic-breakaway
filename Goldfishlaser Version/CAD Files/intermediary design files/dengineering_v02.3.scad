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
magnet_position_z=18.1;
magnet_position_y=4;
magnet_distance=23;

//breakaway magnet

//USB_port variables
u_h = 14.2;
u_w = 13.5;
u_d = 5.7;

//pogo variables

pogo_length=7.6;
pogo_diameter=2.6; //+.3 +.2 +.2 +.2
pogo_distance=1.5; //distance between pins 
shift=2.5; //distance from pins 
shift2=2; //distance from top

//receptor variables

//breakaway variables
i_h = 29; //x
i_w = 8; //z
i_d = 20; //y

//release variables
i_l_h =i_h; //x
i_l_w = i_w; //z
i_l_d = 20; //y

//pogo pins

module pogos(){
    translate([-.7,-.1,4.2]){
        translate([shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+pogo_diameter+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
            translate([(pogo_distance+pogo_diameter)*2+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([(pogo_distance+pogo_diameter)*3+shift,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}
}

//pogos();

size_difference = .75;

module pogo_recs(){
    translate([-.7,-.1,4.2]){
        translate([shift,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+pogo_diameter+shift,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
            translate([(pogo_distance+pogo_diameter)*2+shift,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([(pogo_distance+pogo_diameter)*3+shift,0,0])rotate ([90,0,0])scale(size_difference)cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}
}

//pogo_recs();

module usb(){
    color("grey",.1)translate([-1,3.8,0])cube(size = [u_h,u_w,u_d],center=false);
}

//usb();
//pogo receptors

module recs(){

}

//recs();

magnet_tolerance= .1;

module magnet(){
color("grey") rotate ([90,0,0])translate([magnet_position_x,magnet_position_y,magnet_position_z])cylinder($fn = 30, $fa = 30, $fs = 2, h=4, r1=2.15+magnet_tolerance, r2=2.15+magnet_tolerance, center = true);
    
   color("grey") rotate ([90,0,0])translate([magnet_position_x+magnet_distance,magnet_position_y,magnet_position_z])cylinder($fn = 30, $fa = 30, $fs = 2, h=4, r1=2.15, r2=2.15, center = true);
    

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
translate([24.5,17,0])magnet();
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
   module assemble3(){ 
    difference(){
       release_block();
    translate([5,-i_l_d+3,0])void();


}

 //translate([5,-i_l_d+3,0])void();
}

//outie block

pogo_house_x = 17;
pogo_house_y = 3;
pogo_house_z =3;
pogo_house_pos_x= 30;
pogo_house_pos_y= 0;
pogo_house_pos_z= 2.75;


block_distance=25;    
        module breakaway_block(){
    color("Pink",.55)
 rotate([90,0,0]){
            translate([block_distance,0,0]){
                cube(size = [i_h, i_w, 2], center = false);
            }
        } 
    translate([pogo_house_pos_x,pogo_house_pos_y,pogo_house_pos_z])cube(size = [pogo_house_x,pogo_house_y,pogo_house_z], center=false);
        } 
  //breakaway_block();
        
     
 
 //innie block

innie_tolerance=.5;         
        
 block_distance2=25;    
        module breakaway_block2(){
    color("purple",.55)
 translate([25,0,0])rotate([90,0,0]){
            translate([block_distance2,0,0]){
                cube(size = [i_h, i_w, 5], center = false);
            }
        } 
        }        
//breakaway_block2();
     
 pogo_house2_pos_x= pogo_house_pos_x+25.5;
 pogo_house2_pos_y= pogo_house_pos_y-1;
 pogo_house2_pos_z= pogo_house_pos_z;  
        
 module void3(){
     translate([pogo_house2_pos_x-(innie_tolerance*.5),pogo_house2_pos_y,pogo_house2_pos_z-(innie_tolerance*.5)])cube(size = [pogo_house_x+innie_tolerance,pogo_house_y+innie_tolerance,pogo_house_z+innie_tolerance], center=false);
     translate([55.5,-2.6,0])pogos();
     translate([49.5,16.5,0])magnet();
     }    
        
//void3();    
 
 module assemble2(){
 difference(){
 breakaway_block2();
 void3();
 }    
 }
 translate([5,0,0])assemble2();
    
module assemble(){
translate([0,0,0])difference(){
      breakaway_block();
    void2();
   
}
}

assemble();   





