/*                      
Buskill USB-A Magnetic Release Shell Assembly     
GNU General Public License v3.0 
Author: Melanie Allen
*/

/*
Description

BusKill is a Dead Man Switch triggered when a magnetic breakaway is tripped, severing a USB connection. This design is for USB-A.

The user will have a USB, a USB extension cable, and the magnetic breakaway. 

The magnetic breakaway device should be sized so that it doesn't base other USB ports on the user's computer.

The "input" receives the USB from the USB cable with a female USB port. It is in two parts, the base and the lid. It contains pogo pins and magnets. 

The "output" plugs into the computer with a male USB. It is in two parts, the base and the lid. It contains pogo receptors and magnets. 

When the magnets on the input and output connect, the pogo pins and pogo receptors must meet and establish the USB connection.

The input and output plugs must be designed asymmetrically to prevent the connection from happening the wrong way. 

The case must be designed so that the user can completely dissemble it and ensure there has been no tampering. No glue must be required. The base and lid connect together with tiny screws and embedded nuts. 

docs.buskill.in
buskill.in
*/

/* * * * Variables* * * */

/* * Input * */

//input base variables
i_h = 18; //z
i_w = 6.5; //x
i_d = 24; //y

//input lid variables
i_l_h =18; //z
i_l_w = 8.5; //x
i_l_d = 24; //y

//USB_female variables
uf_h = 16;
uf_w = 13;
uf_d = 6.75;

//pogo recepticle variables
//Pogo recepticle is shaped like two cylinders, a larger one on top of a smaller one
ppr_top_d=3.1; // top cyclinder diameter
ppr_top_r=1.5;
ppr_top_h=1.5; // top cylinder height
ppr_bottom_d=2; //bottom cylinder diameter
ppr_bottom_r=1;
ppr_bottom_h1=2; //bottom cyclinder height

/* * Output * */

//output base variables
o_h = 14; //z
o_w = 6.5; //x
o_d = 12; //y

//output lid variables
o_l_h =14; //z
o_l_w = 3.25; //x
o_l_d = 13; //y

//pogo variables
pogo_length=15;
pogo_tip=3;
pogo_diameter=1.6;
pogo_distance=2.3; //distance between pins (x=z)

//USB_male variables
um_h = 12;
um_w = 10;
um_d = 4;

//screw and nut variables
s_h=6;
s_d=1;
n_s=1;


/* * * * Modules * * * */

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
            translate([0,0,pogo_distance]){
                pogo_cut();
                };
        };
    translate([0,0,pogo_distance]){
        pogo_cut();
        };
    }
};

//pogo_assemble();

//create pogo recepticle
//variables: ppr_top_r, ppr_top_h, ppr_bottom_r, ppr_bottom_h

module pogo_rec(){
    module pogo_rec_top(){
        cylinder(h=ppr_top_h, r1=ppr_top_r, r2=ppr_top_r, center = false);
    };
 pogo_rec_top();   
    module pogo_rec_bottom(){
        translate([0,0,-1]){
            cylinder(h=ppr_bottom_h, r1=ppr_bottom_r, r2=ppr_bottom_r, center = false);
        }
    };
    pogo_rec_bottom();
}

module two_pogo_recs(){
    rotate([90,0,0]){
pogo_rec();
    
translate([pogo_distance+1,0,0]){
pogo_rec();
}
}
}
//two_pogo_recs();

//create input base
module input(){
    difference(){
    rotate([90,0,0]){
        translate([52,0,0]){
        cube(size = [i_h, i_w, i_d], center = false);   
            }
        }
            translate([58,-24,1]){
cube(size= [6,2,5]);
            }
    }   
    };  

//input();

//create output base
module output(){
       rotate([90,0,0]){
            translate([33,0,0]){
                cube(size = [o_h, o_w, o_d], center = false);
            }
        }
        translate([37,-13,1]){
            cube(size= [6,2,5]);
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
    translate([52.4,-27.15,-4.25]){
        magnet();
        translate([13.1,0,0]){
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
module create_output(){

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
};

//create_output();

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


module create_input(){
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
}

module make_screws(){    
    module screw(){
        cylinder(h=s_h, r1=s_d, r2=s_d, center = false);
    }

    module two_screws(){
        translate([0,-17,0]){
        screw();
    }

    translate([10,-17,0]){
        screw();
        }
    }

    translate([56,0,0]){
        two_screws(); //for output base
    }

    translate([116,34,0]){
        two_screws(); // for output lid
    }
};
//make_screws();

module make_nuts(){
    //for differencing
}
//make_nuts();

module done(){
    difference(){
        create_input(); //renders input lid and base
        make_nuts(); //subtract nuts
    }


    difference(){
       create_output(); //renders output lid and base
        make_screws(); //subtracts screws
    }
};
done();

