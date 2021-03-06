/*                      
Buskill USB-A Magnetic breakaway Shell Assembly     
GNU General Public License v3.0 
Author: Melanie Allen
*/

/*
Description

BusKill is a Dead Man Switch triggered when a magnetic breakaway is tripped, severing a USB connection. This design is for USB-A.

The user will have a USB, a USB extension cable, and the magnetic breakaway. 

The magnetic breakaway device should be sized so that it doesn't block other USB ports on the user's computer.

The "breakaway" receives the USB from the USB cable with a female USB port. It is in two parts, the base and the lid. It contains pogo pins and magnets. It separates from the release when the cord is pulled.

The "release" plugs into the computer with a male USB. It is in two parts, the base and the lid. It contains pogo receptors and magnets. 

When the magnets on the breakaway and release connect, the pogo pins and pogo receptors must meet and establish the USB connection.

The breakaway and release plugs must be designed asymmetrically to prevent the connection from happening the wrong way. 

The case must be designed so that the user can completely dissemble it and ensure there has been no tampering. No glue must be required. The base and lid connect together with tiny screws and embedded nuts. 

docs.buskill.in
buskill.in
*/

/* * * * TO DO * * * */

//add z-fighter where applicable 
//make rendering each part individually easy
//adjust pogo distance or magnet? to resolve not manifold error
//move nut slot and screw voids in place
//move pogo_recs in place
//add notch

zfighter = 0.02; //value to prevent z-fighting

/* * Magnet * */

//Download magnet2.stl from repo into the same folder as this .scad file

magnet_distance=9.5;

module magnet(){
    color( "SlateGrey", 1.0 )
    rotate([0,90,0]){
        import("magnet2.stl");
    }
}
//magnet();

/* * Notch * */

//The notch should extrude from the release, and cut into the breakaway so that they can only connect in one orientation.

module notch(){
    color("white"){
        rotate([90,0,0]){
            cylinder(.5,.5,.5,$fn=3);
        }
    }
}
//notch();

/* * * Create breakaway * * */
 
 //The "breakaway" receives the USB from the USB cable with a female USB port. It is in two parts, the base and the lid. It contains pogo pins and magnets.

/* * Variables * */

//breakaway base variables
i_h = 18; //z
i_w = 6.5; //x
i_d = 24; //y
 
i2_h = 6; //z
i2_w = 2; //x
i2_d = 5; //y

//breakaway lid variables
i_l_h =i_h; //z
i_l_w = i_w; //x
i_l_d = i_d; //y

i2_l_h =i2_h; //z
i2_l_w = i2_w; //x
i2_l_d = i2_d; //y

//USB_female variables
uf_h = 16;
uf_w = 13;
uf_d = 6.75;

//pogo variables
//pogo pins are shaped like a cylinder.

pogo_length=12;
pogo_tip=3;
pogo_diameter=1.6;
pogo_distance=3.2+zfighter; //distance between pins (x=z)

/* *  Modules * */

module breakaway_base(){
    color("pink"){
    difference(){
    rotate([90,0,0]){
        translate([52,0,zfighter]){
        cube(size = [i_h, i_w, i_d], center = false);   
            }
        }
            translate([58,-24,1+zfighter]){
cube(size= [i2_h,i2_w,i2_d], center = false);
            }
    }   
}
    };  

// breakaway_base();

module breakaway_lid(){
            color("red"){
    rotate([90,0,0]){
       translate([52,3.25,zfighter]){
            cube(size = [i_l_h, i_l_w, i_l_d], center = false);   
            }
     }
}     
}
// breakaway_lid();
    
module pogo_pin(){
    color("yellow"){
        rotate([90,0,0]){
            cylinder(h=pogo_length, r1=pogo_diameter, r2=pogo_diameter, center = false);
        translate([pogo_distance,0,0]){
            cylinder(h=pogo_length, r1=pogo_diameter, r2=pogo_diameter, center = false);
        }
    }
}
}
//pogo_pin();

module subtract_pogo_pin(){
}
//subtract_pogo_pin();

  
module breakaway_add_notch(){
}
//add_notch();

module breakaway_subtract_magnets(){
        module breakaway_magnet(){
        translate([33.25,-15.15,-4.25-zfighter]){
            magnet();
            translate([magnet_distance,0,-zfighter]){
                magnet();
            }
        }
    }
//breakaway_magnet();
    difference(){
        breakaway_base();
        breakaway_magnet();
    }
}
    

//breakaway_subtract_magnets();

module subtract_usb_f(){
        module usb_female(){
    translate([0,0,0]){
        cube(size=[uf_h,uf_w,uf_d], center = false);
    }
}
usb_female();
    difference(){
        breakaway_subtract_magnets();
        usb_female();
    }
}
//subtract_usb_f();

/* * * Create release * * */

//The "release" plugs into the computer with a male USB. It is in two parts, the base and the lid. It contains pogo receptors and magnets.

/* * Variables * */
    
//release base variables
o_h = 14; //z
o_w = 6.5; //x
o_d = 12; //y

//release lid variables
o_l_h =14; //z
o_l_w = 3.25; //x
o_l_d = 13; //y

//pogo receptor variables
//Pogo receptor is shaped like two cylinders, a larger one on top of a smaller one
ppr_top_d=3.1; // top cyclinder diameter
ppr_top_r=1.5;
ppr_top_h=1.5; // top cylinder height
ppr_bottom_d=2; //bottom cylinder diameter
ppr_bottom_r=1;
ppr_bottom_h=2; //bottom cyclinder height
ppr_d=1; //distance between pogo receptors

//USB_male variables
um_h = 12;
um_w = 10;
um_d = 4;

//screw and nut variables
s_h=6; // screw length
s_r1=.5; // screw shaft radius
s_r2=1; // screw top radius
n_r=1; //nut radius
n_h=1; //nut height
n_d=5; //distance between nuts

/* * Modules * */

//create release base
module release(){
       rotate([90,0,0]){
            translate([33,0,0]){
                cube(size = [o_h, o_w, o_d], center = false);
            }
        }
        translate([37,-13,1]){
            cube(size= [6,2,5]);
        }   
}; 
//release();

module create_release_lid(){
       rotate([90,0,0]){
        translate([33,3.25,zfighter]){
        cube(size = [o_l_h, o_l_w, o_l_d], center = false);
            }
        } 
    };     
//create_release_lid();

module two_pogo_recs(){  
    module pogo_rec(){
        //variables: ppr_top_r, ppr_top_h, ppr_bottom_r, ppr_bottom_h
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
//pogo_rec();

    rotate([90,0,0]){
        pogo_rec();
    
        translate([pogo_distance,0,0]){
        pogo_rec();
        }
    }
}
//two_pogo_recs();

module release_subtract_magnet(){
    module release_magnet(){
        translate([33.25,-15.15,-4.25-zfighter]){
            magnet();
            translate([magnet_distance,0,-zfighter]){
                magnet();
            }
        }
    }
//release_magnet();
    difference(){
        release();
        release_magnet();
    }
}

//release_subtract_magnet();

module create_release(){

    module subtract_usb_f() {
        //create usb_female
        module usb_female(){
            translate([53,-9,1]){
            cube(size=[uf_h,uf_w,uf_d], center = false);
            }
        }
        //usb_female();
        difference(){
            release_subtract_magnet();
            usb_female();
        }
    }


    difference(){
        pogo_recs();
        release_lid();
    }

};

//create_release();

module subtract_usb_m(){
    module usb_male(){
    translate([34,-10,1]){
        cube(size=[um_h,um_w,um_d], center = false);
    }
}
//usb_male();
    difference(){
        release_subtract_magnet();
        usb_male();
    }
}
//subtract_usb_m();

module subtract_receptors(){
    color("blue"){
        difference(){
            subtract_usb_m();
            translate([0,0,0]){
                two_pogo_recs(); 
            }
        }
    }
    translate([38,-38,0]){
                two_pogo_recs(); 
            }
            }
//subtract_receptors();
            
//subtract notch
module release_subtract_notch(){
}
//release_subtract_notch();

module make_screw_tops(){    
    module screw(){
        cylinder(h=s_h, r1=s_r1, r2=s_r2, center = false);
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
        two_screws(); //for release base
    }

    translate([116,34,0]){
        two_screws(); // for release lid
    }
};
//make_screws_tops();

module make_screw_bottoms(){    
    module screw(){
        cylinder(h=s_h, r1=s_r1, r2=s_r2, center = false);
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
        two_screws(); //for release base
    }

    translate([116,34,0]){
        two_screws(); // for release lid
    }
};
//make_screws_bottoms();

module make_nuts(){
  module nut(){
    rotate([90,0,0]){
        translate([n_d,0,0]){
        cylinder(h=1, r1=n_r, r2=n_r, center= false);
            }
        }
    }
  nut(); //make one nut
    translate([n_d,0,0]){
      nut(); //make one nut n_d distance from the first nut
    }
}

//make_nuts(); //two nuts


/* * * RENDER THE PARTS * * */

module create_all(){

//render breakaway lid
   create_breakaway_lid();

//render breakaway base
   create_breakaway();

//render release lid
   create_release_lid(); 

 //render release base   
   create_release();
}
//create_all();

/* * * RENDER A PART * * */

//create_breakaway();
//create_breakaway_lid();
//create_release();
//create_release_lid();
