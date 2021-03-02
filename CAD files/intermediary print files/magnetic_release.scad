/*                      
Buskill USB-A Magnetic Release Shell Assembly     
GNU General Public License v3.0 
Author: Melanie Allen
*/

//input block variables
i_h = 18;
i_w = 8.5;
i_d = 24;

//output block variables
o_h = 14;
o_w = 6.5;
o_d = 12;

//input lid variables
i_l_h =18;
i_l_w = 6.25;
i_l_d = 24;

//output lid variables
o_l_h =14;
o_l_w = 3.25;
o_l_d = 13;

//pogo variables
pogo_length=15;
pogo_tip=3;
pogo_diameter=1.5;
pogo_distance=1;

//USB_female variables
uf_h = 16;
uf_w = 13;
uf_d = 6.75;

//USB_male variables
um_h = 12;
um_w = 10;
um_d = 4;


// modules
//create input lid
module input_lid(){
    difference(){
    rotate([90,0,0]){
        translate([52,3.25,0]){
        cube(size = [i_l_h, i_l_w, i_l_d], center = false);   
            }
        }
    }   
    };  
    
 //   input_lid();

//create output lid
module output_lid(){
       rotate([90,0,0]){
        translate([33,3.25,0]){
        cube(size = [o_l_h, o_l_w, o_l_d], center = false);
            }
        } 
    };     
//output_lid();

//create pogo pin 
module pogo_cut(){
rotate([90,90,0]) {
    cylinder(h=pogo_length, r1=pogo_diameter, r2=pogo_diameter, center = false);
    translate([0,0,pogo_length]) {
        cylinder(h=pogo_tip, r1=1, r2=1, center = false);
        }
}
}

//pogo_cut();

module pogo_assemble(){
translate([38.5,4.5,2]){
    pogo_cut();
translate([pogo_diameter*1.5,0,0]){
    pogo_cut();
    translate([0,0,pogo_diameter*1.5]){
        pogo_cut();
    };
    };
translate([0,0,pogo_diameter*1.5]){
    pogo_cut();
    };
}
};

//pogo_assemble();

//create input block
module input(){
    difference(){
    rotate([90,0,0]){
        translate([52,0,0]){
        cube(size = [i_h, i_w, i_d], center = false);   
            }
        }
            translate([58.5,-24,1]){
cube(size= [4.5,2,5]);
            }
    }   
    };  

//input();

//create output block
module output(){
       rotate([90,0,0]){
        translate([33,0,0]){
        cube(size = [o_h, o_w, o_d], center = false);
            }
        }
     translate([38,-13,1]){
cube(size= [4,2,5]);
    }   
    };       


//output();

//create magnet
module magnet(){
    color( "SlateGrey", 1.0 )
    rotate([0,90,0]){
        import("magnet2.stl");
    }
}
//magnet();

//create two magnets for input
module input_magnet(){
translate([54.4,-27.15,-4.25]){
    magnet();

    translate([9.5,0,0]){
        magnet();
        }
    }
}

//create two magnets for output
module output_magnet(){
translate([33.25,-15.15,-4.25]){
    magnet();
translate([9.5,0,0]){
    magnet();
        }
    }
}

//add magnet void to input
module input_add_magnet(){

difference(){
    input();
    input_magnet();
    }
}

//input_add_magnet();

//add magnet void to output
module output_add_magnet(){
    difference(){
        output();
        output_magnet();
    }
}

//output_add_magnet();

//create usb_female
module usb_female(){
    translate([53,-9,1]){
        cube(size=[uf_h,uf_w,uf_d], center = false);
    }
}

//usb_female();

//subtract usb_female

module subtract_usb_f() {
difference(){
input_add_magnet();
usb_female();
}
}

module almost_done_input() {
color("pink"){
difference(){
subtract_usb_f();
    translate([21,-10,-0]){
        pogo_assemble();
        };
}
}
}

difference(){
    almost_done_input();
    input_lid();
}

rotate([180,00,0]){
    translate([60,0,-8.5]){
    difference(){
        almost_done_input();
        translate([0,0,-6.25]){
            input_lid();
        }
    }
}
}

//create usb_male
module usb_male(){
    translate([34,-10,1]){
        cube(size=[um_h,um_w,um_d], center = false);
    }
}
//usb_male();

//subtract usb_male
module subtract_usb_m(){
difference(){
output_add_magnet();
usb_male();
}
}

//subtract_usb_m();
module almost_done_output(){
color("blue"){
difference(){
    subtract_usb_m();
    pogo_assemble();
}
}
}

difference(){
    almost_done_output();
    output_lid();
}

rotate([180,0,0]){
    translate([50,0,-6.5]){
    difference(){
        almost_done_output();
        translate([0,0,-3.25]){
            output_lid();
            }
    }
}
}
    
module screw(){
    //for differencing
}
//screw();

module nut(){
    //for differencing
}
//nut();