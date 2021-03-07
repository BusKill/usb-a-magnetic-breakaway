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

/* * Screw and Nut * */
s_h=6; // screw length
s_r1=.5; // screw shaft radius
s_r2=1; // screw top radius
n_l=6; //nut channel length
n_h=1; //nut height
n_d=14; //distance between nuts

/* * * Create breakaway * * */
 
 //The "breakaway" receives the USB from the USB cable with a female USB port. It is in two parts, the base and the lid. It contains pogo pins and magnets.

/* * Variables * */

//breakaway base variables
i_h = 18; //z
i_w = 3.25; //x
i_d = 24; //y
 
i2_h = 8; //x
i2_w = 2; //y
i2_d = 2.5; //z

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
module create_breakaway(){
module breakaway_base(){
    color("pink", .5){
    difference(){
    rotate([90,0,0]){
        translate([52,0,zfighter]){
        cube(size = [i_h, i_w, i_d], center = false);   
            }
        }
            translate([57,-24,1+zfighter]){
cube(size= [i2_h,i2_w,i2_d], center = false);
            }
    }   
}
    };  

 //breakaway_base();

module breakaway_lid(){
            color("red", .5){
    rotate([90,0,0]){
       translate([114,0,0]){
            cube(size = [i_l_h, i_l_w, i_l_d], center = false);   
            }
     }
}     
}
 breakaway_lid();
    
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
    difference(){
        breakaway_base();
        translate([59.5,-13,1.625]){
            pogo_pin();
        }
    }
}
//subtract_pogo_pin();

  
module breakaway_add_notch(){
}
//add_notch();


module breakaway_subtract_magnets(){
        module breakaway_magnet(){
        translate([54,-27.17,-5.25-zfighter]){
            magnet();
            translate([magnet_distance,0,-zfighter]){
                magnet();
            }
        }
    }
    //breakaway_magnet();

    difference(){
        subtract_pogo_pin();
        breakaway_magnet();
    }
}
    

//breakaway_subtract_magnets();

module subtract_usb_f(){
        module usb_female(){
    translate([53,-uf_w,.5]){
        cube(size=[uf_h,uf_w,uf_d], center = false);
    }
}
//usb_female();
    difference(){
        breakaway_subtract_magnets();
        usb_female();
    }
}
//subtract_usb_f();

module make_screw_tops_breakaway(){    
    module screw_tops_breakaway(){
        cylinder(h=s_h, r1=s_r1, r2=s_r2, center = false);
    }

    module two_screws_tops_breakaway(){
        translate([0,-17,0]){
        screw_tops_breakaway();
    }

    translate([10,-17,0]){
        screw_tops_breakaway();
        }
    }

    translate([56,0,0]){
        two_screws_tops_breakaway(); //for breakaway base
    }

    translate([116,0,0]){
        two_screws_tops_breakaway(); // for breakaway lid
    }
};
//make_screw_tops_breakaway();

module subtract_screw_tops_breakaway(){
    difference(){
        subtract_usb_f();
        make_screw_tops_breakaway();
    }
}
//subtract_screw_tops_breakaway();

module make_nuts_breakaway(){
  module nut_breakaway(){
    rotate([90,90,0]){
        translate([0,0,0]){
        cube(size=[n_h,n_l,n_h], center = false);
            }
        }
    }
  nut_breakaway(); //make one nut
    translate([n_d,0,0]){
      nut_breakaway(); //make one nut n_d distance from the first nut
    }

}


module subtract_nuts_breakaway_base(){
    difference(){
        subtract_screw_tops_breakaway();
        translate([51,-16.5,1.5]){
            make_nuts_breakaway(); //two nuts
            }
    }
}
subtract_nuts_breakaway_base();
}
//create_breakaway();

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


/* * Modules * */

module release_base(){
       rotate([90,0,0]){
            translate([33,0,0]){
                cube(size = [o_h, o_w, o_d], center = false);
            }
        }
        translate([37,-13,1]){
            cube(size= [6,2,5]);
        }   
}; 
//release_base();

module release_lid(){
  release_base();
}
//release_lid();

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
        release_base();
        release_magnet();
    }
}

//release_subtract_magnet();

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

module make_screw_tops_release(){    
    module screw_tops_release(){
        cylinder(h=s_h, r1=s_r1, r2=s_r2, center = false);
    }

    module two_screws_tops_release(){
        translate([0,-17,0]){
        screw_tops_release();
    }

    translate([10,-17,0]){
        screw_tops_release();
        }
    }

    translate([56,0,0]){
        two_screws_tops_release(); //for release base
    }

    translate([116,34,0]){
        two_screws_tops_release(); // for release lid
    }
};
//make_screws_tops_release();

module make_screw_bottoms_release(){    
    module screw_release(){
        cylinder(h=s_h, r1=s_r1, r2=s_r2, center = false);
    }

    module two_screws_release(){
        translate([0,-17,0]){
        screw_release();
    }

    translate([10,-17,0]){
        screw_release();
        }
    }

    translate([56,0,0]){
        two_screws_release(); //for release base
    }

    translate([116,34,0]){
        two_screws_release(); // for release lid
    }
};
//make_screws_bottoms_release();

module make_nuts_release(){
  module nut_release(){
    rotate([90,90,0]){
        translate([0,0,0]){
        cube(size=[n_h,n_l,n_h], center = false);
            }
        }
    }
  nut_release(); //make one nut
    translate([n_d,0,0]){
      nut(); //make one nut n_d distance from the first nut
    }
}

//make_nuts_release(); //two nuts


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

create_breakaway();
//create_breakaway_lid();
//create_release();
//create_release_lid();
