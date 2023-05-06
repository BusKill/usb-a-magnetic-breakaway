/*  
__________                       ___
\______   \_______   ____ _____  |  | _______ __  _  _______  ___.__.
 |    |  _/\_  __ \_/ __ \\__  \ |  |/ /\__  \\ \/ \/ /\__  \<   |  |
 |    |   \ |  | \/\  ___/ / __ \|    <  / __ \\     /  / __ \\___  |
 |______  / |__|    \___  >____  /__|_ \(____  /\/\_/  (____  / ____|
        \/              \/     \/     \/     \/             \/\/     

*/

/* * * Create Breakaway * * */
 
 // The "breakaway" is connected to a USB extension cord that terminates with the female USB port that receives a USB. It is in four parts, the base, two middle pieces, and the lid. It contains 5 pogo pins and 2 magnets. It separates from the release when the cord is pulled. (red)

magnet_distance=16;

//breakaway base variables
i_h = 22; //x
i_w = 13; //z
i_d = 16; //y
 
i2_h = 8; //x
i2_w = 0; //y
i2_d = 2.5; //z

//breakaway top variables
i_l_h =i_h; //z
i_l_w = i_w; //x
i_l_d = i_d; //y

i2_l_h =i2_h; //z
i2_l_w = i2_w; //x
i2_l_d = i2_d; //y

//pogo variables
//pogo pins are shaped like a cylinder.

pogo_length=18;
pogo_tip_diameter=1;
pogo_diameter=1.8;
pogo_distance=4; //distance between pins (x=z)

module pogos(){
        rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=1.8, r2=1.15, center = true);
    translate([pogo_distance,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 1.8, h=pogo_length, r1=1.8, r2=1.15, center = true);
}

//pogos();

module magnets(){
    rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=2.4, r1=2, r2=2, center = true);
    
    translate([magnet_distance,0,0])rotate ([90,0,0])cylinder($fn = 30, $fa = 30, $fs = 2, h=2.4, r1=2, r2=2, center = true);
    
}

//magnets();

module void(){
    translate([5,pogo_length/2-1,0])pogos();
    magnets();
    
    
        translate([5,pogo_length/2-1,0])pogos();
    magnets();
}

// translate([3,-15,3])void();
// translate([3,-15,9])void();

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
    
        module base_block(){
    color("Pink",.55)
 rotate([90,0,0]){
            translate([33,0,0]){
                cube(size = [i_l_h, i_l_w, i_l_d], center = false);
            }
        } 
    } 
  //  base_block();
    
difference(){
       top_block();
    translate([3,-15,3])void();
    translate([3,-15,9])void();

}
