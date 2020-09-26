/*                      
Buskill USB-A Magnetic Release Shell Assembly                 
CC BY-NC 3.0 License     
Author: Melanie Allen
*/


// modules
module pogopin() {
   color("Purple",1.0)translate([0,0,2.5]){
    import("pogo_pin.stl");
        rotate([0,180,0])translate([-6.6,0,-1]){
               import("pogo_pin.stl");
    }
        }
    }



module magnet(){
    color( "SlateGrey", 1.0 )
    rotate([0,90,0]){
        import("magnet2.stl");
    }
}

module usb_female(){
    cube(size=[4,10,2], center = false);
}

module usb_male(){
    cube(size=[4,10,2], center = false);
}
    
module screw(){
}

module nut(){
}

/* module top_input(){
    color( "Green", 0.5 )
    rotate([90,0,0]){
        cube(size = [14, 2.25, 24], center = false);
    }
}   

module top_output(){
    color( "Green", 0.5 )
    rotate([90,0,0]){
        translate([15,0,0]){
        cube(size = [14, 2.25, 12], center = false);
        }
    }    
}
*/
module bottom_input(){
    color( "Green", 0.5 ){
    rotate([90,0,0]){
        translate([52,0,0]){
        cube(size = [14, 6.25, 24], center = false);   
        }
    }
}
}

module bottom_output(){
    color( "Green", 0.5 ){
       rotate([90,0,0]){
        translate([33,0,0]){
    cube(size = [14, 6.25, 12], center = false);
        }
    }
}
}            

//input top
/* difference(){
top_input(); 
    usb_female();
}
*/
//input bottom
bottom_input();

           

//output top
//top_output();

translate([36.5,-12.1,0]){
pogopin();
}
translate([33.25,-15.15,-4.25]){
    magnet();
translate([9.5,0,0]){
    magnet();
}
}
//output bottom
    translate([55.5,-24.1,0]){
        pogopin();
        }

    bottom_output();

translate([52.25,-27.15,-4.5]){
    magnet();

translate([9.5,0,0]){
    magnet();
}
}
