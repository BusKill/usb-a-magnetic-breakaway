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

The "breakaway" consists of areas for two disc magnets and an indention to house pogo receptors. (purple)

The "release" consists of areas for two disk magnets and an extrusion to house pogo pins. (pink)

When the magnets on the breakaway and release connect, the pogo pins and pogo receptors must meet and establish the USB connection.

The breakaway and release plugs must be designed asymmetrically to prevent the connection from happening the wrong way. 

In this version I have borrowed these mangets and pogo receptors from the Supplier verison of the BusKill cable.

docs.buskill.in
buskill.in
*/

//TODO: decrease channel block height, improve jig, create two case bodies

CubePoints = [
  [  0,  0,  0 ],  //0
  [ 10,  0,  0 ],  //1
  [ 10,  7,  0 ],  //2
  [  0,  7,  0 ],  //3
  [  0,  0,  5 ],  //4
  [ 10,  0,  5 ],  //5
  [ 10,  7,  5 ],  //6
  [  0,  7,  5 ]]; //7
  
CubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
translate([70,0,0])polyhedron( CubePoints, CubeFaces );

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
shift=2.1; //distance from pins 
spread=4.8;
shift2=2; //distance from top

//receptor variables

//breakaway variables
i_h = 30; //x
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
    translate([pogo_distance+spread,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
            translate([pogo_distance+spread*2,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
    translate([pogo_distance+spread*3,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=pogo_diameter/2, r2=pogo_diameter/2, center = true);
}
}

//pogos();

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

//RELEASE

pogo_house_x = 17.5;
pogo_house_y = 1;
pogo_house_z =4;
pogo_house_pos_x= 31.75;
pogo_house_pos_y= 0;
pogo_house_pos_z= 2.25;


block_distance=25;    
        module release_block(){
    color("Pink",.55)
 rotate([90,0,0]){
            translate([block_distance,0,0]){
                cube(size = [i_h, i_w, 2], center = false);
                cube(size = [2, 2, 2], center = false);
            }
        } 
    translate([pogo_house_pos_x,pogo_house_pos_y,pogo_house_pos_z])cube(size = [pogo_house_x,pogo_house_y,pogo_house_z], center=false);

        } 
  //release_block();
        
 color("Pink",.55) translate([block_distance,-26,0])cube(size = [i_h, 20, 4], center = false);
        
        
  
 
 //BREAKAWAY

innie_tolerance=.5;         
m_step=1.25;        
 block_distance2=25;    
        module breakaway(){
    color("purple",.55)
 translate([25,0,0])
            rotate([90,0,0]){
            translate([block_distance2,0,2]){
                cube(size = [i_h, i_w, 3], center = false);

            }
                           translate([25,0,2]) rotate([-90,0,0]) cube(size = [6.5, m_step, 8], center = false);   
        translate([25+magnet_distance+1.55,0,2])rotate([-90,0,0])cube(size = [5.6, m_step, 8], center = false);
        } 
        
        }   

//breakaway();
     
 pogo_house2_pos_x= pogo_house_pos_x+23.75;
 pogo_house2_pos_y= pogo_house_pos_y-m_step;
 pogo_house2_pos_z= pogo_house_pos_z;  
        
 module void3(){
     translate([pogo_house2_pos_x-(innie_tolerance*.5),pogo_house2_pos_y,pogo_house2_pos_z-(innie_tolerance*.5)])cube(size = [pogo_house_x+innie_tolerance,pogo_house_y+innie_tolerance,pogo_house_z+innie_tolerance], center=false);
     
     translate([55.5,-2.6,0])pogos();
     translate([49.5,16.5,0])magnet();
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

cube(size = [17,7,4],center=false);
        
        translate([0,3.5-1.8,1])pogojig();

    }
 
}
jig();
translate([-25,0,0])jig();