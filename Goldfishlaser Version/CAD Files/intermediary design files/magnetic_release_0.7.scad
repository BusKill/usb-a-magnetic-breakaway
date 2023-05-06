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

The "breakaway" receives the USB from the USB cable with a female USB port. It is in four parts, the base, two middle pieces, and the lid. It contains 4 pogo pins and 2 magnets. It separates from the release when the cord is pulled.

The "release" plugs into the computer with a male USB. It is in three parts, the base, the middle, and the lid. It contains 4 pogo receptors and 2 magnets.

The middle pieces are created in order to stabilize the pogo pins and magnets from the top and bottom pieces to keep them from interfering with each other.

When the magnets on the breakaway and release connect, the pogo pins and pogo receptors must meet and establish the USB connection.

The breakaway and release plugs must be designed asymmetrically to prevent the connection from happening the wrong way. 

The case must be designed so that the user can completely dissemble it and ensure there has been no tampering. No glue must be required. The base and lid connect together with tiny screws and embedded nuts. There will be a middle wall piece for both ends that separates top and bottom components.

The magnets are a custom hexagonal shape so that they can connect at the flat surface and be held in place by the plastic without requiring glue. The engineering document is available on the repo.

docs.buskill.in
buskill.in
*/

/* * * * TO DO * * * */
//figure out exact shapes so that magnets and pogos are secured during assembly
//properly define variables instead of kludging values

module main(){

zpascifier = 0.02; //value to prevent z-fighting

/* * Magnet * */

//Download magnet2.stl from repo into the same folder as this .scad file

magnet_distance=12.5;

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
            cylinder($fn = 30, $fa = 30, $fs = 2, .5,.5,.5,$fn=3);
        }
    }
}
//notch();

/* * Pogo Pin * */
    module pogo_pin(){
    color("yellow"){
        rotate([90,0,0]){
            cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter, r2=pogo_diameter, center = false);
        translate([pogo_distance,0,0]){
            cylinder($fn = 30, $fa = 30, $fs = 2, h=pogo_length, r1=pogo_diameter, r2=pogo_diameter, center = false);
        }
    }
}
}
//pogo_pin();

/* * Screw and Nut * */
s_h=7; // screw length
s_r1=.75; // screw shaft radius
s_r2=2; // screw top radius
n_l=7; //nut channel length
n_h=1.3; //nut height
n_d=14; //distance between nuts
s_d_r=11; //distance between screws release
s_d_b=10; //distance between screws breakaway

/* * * Create Breakaway * * */
 
 //The "breakaway" receives the USB from the USB cable with a female USB port. It is in two parts, the base and the lid. It contains pogo pins and magnets.

/* * Variables * */

//breakaway base variables
i_h = 17.5; //x
i_w = 2.5; //z
i_d = 24; //y
 
i2_h = 8; //x
i2_w = 0; //y
i2_d = 2.5; //z

//breakaway lid variables
i_l_h =i_h; //z
i_l_w = i_w; //x
i_l_d = i_d; //y

i2_l_h =i2_h; //z
i2_l_w = i2_w; //x
i2_l_d = i2_d; //y

//cut_female variables
cf_h = 19; //the width for some reason
cf_w = 13; //the height 
cf_d = 5.75; // the same as cf_w for some reason... 

//pogo variables
//pogo pins are shaped like a cylinder.

pogo_length=12;
pogo_tip=1.5;
pogo_diameter=1.5;
pogo_distance=3.5+zpascifier; //distance between pins (x=z)

module breakaway_magnet(){
        translate([52.5,-27.17,-5]){
            magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();
            }
        }
    }
    //breakaway_magnet();
    
/* *  Build Modules * */
 module cut_female(){
    translate([51,-cf_w,-1.5]){
        cube(size=[cf_h,cf_w,cf_d], center = false);
    }
}
//cut_female();
    module breakaway_base(){
    color("pink", .5){
    difference(){
    rotate([90,0,0]){
        translate([52,0,zpascifier]){
        cube(size = [i_h, i_w, i_d], center = false);   
            }
        }
            translate([57,-24,1+zpascifier]){
cube(size= [i2_h,i2_w,i2_d], center = false);
            }
    }   
}
    };  

//breakaway_base();
module create_breakaway(){
    module subtract_pogo_pin(){
    difference(){
        breakaway_base();
        translate([59.2,-13,1.625]){
            pogo_pin();
        }
    }
}
//subtract_pogo_pin();

    
    module breakaway_add_notch(){
}
//add_notch();

    module breakaway_subtract_magnets(){


    difference(){
        subtract_pogo_pin();
        breakaway_magnet();
    }
}
    

//breakaway_subtract_magnets();

module subtract_cut_f(){

//cut_female();
    difference(){
        breakaway_subtract_magnets();
        translate([0,0,-.7])cut_female();
        
    }
}
//subtract_cut_f();

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
        subtract_cut_f();
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
part_loc_x=90;

module create_breakaway_lid(){
    
    module breakaway_lid_block(){
            color("red", .5){
    rotate([90,0,0]){
       translate([part_loc_x,0,11.5]){
            cube(size = [i_l_h, i_l_w/2, i_l_d/2], center = false);   
            }
     }
}     
}
//breakaway_lid_block();
screw_depth=-16;
screw_distance=11;
 
        module void(){
        translate([7.5,-13.1,1.625]){
            pogo_pin();
            } //subtract pogo_pin
        translate([.5,-27.17,-5]){
            magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();
            } //subtract magnets
        }         
            translate([62,zpascifier,-zpascifier]){
            cut_female(); //subtract usb
            }
              module screw(){
        cylinder($fn = 30, $fa = 30, $fs = 2,h=s_h, r1=s_r1, r2=s_r2, center = false);
        translate([screw_distance,0,0])cylinder($fn = 30, $fa = 30, $fs = 2,h=s_h, r1=s_r1, r2=s_r2, center = false);
    }
  translate([3.5,screw_depth,1]){
        screw();
    }
  
    };
//translate([part_loc_x,0,0]) {void();}
difference(){
    breakaway_lid_block();
    translate([part_loc_x,0,0]) {void();}
}
};
    

//create_breakaway_lid();

module create_breakaway_m(){
    module screw(){
        cylinder($fn = 30, $fa = 30, $fs = 2,h=s_h, r1=s_r1, r2=s_r2, center = false);
        translate([11,0,0])cylinder($fn = 30, $fa = 30, $fs = 2,h=s_h, r1=s_r1, r2=s_r2, center = false);
    }
    
    //block
    module block(){
    color("DeepPink",.55)
    translate([46,-30,0])  rotate([90,0,0]){
            translate([33,0,0]){
                cube(size = [i_l_h, i_l_w/2, i_l_d/2], center = false);
            }
        } 
    } 

    module void(){
        translate([86,-30,-1.2]) pogo_pin();
        translate([86,-30,2.2]) pogo_pin(); //cut pogos    
        
translate([82,-33,-zpascifier]) screw();//cut holes  
            translate([79.5,-45.25,-6]){magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();  }}
//cut magnets 
    }
    
        difference(){
        block();
        void();
    
        
    }
    
        //void();
}


/* * * Create Release * * */

//The "release" plugs into the computer with a male USB. It is in two parts, the base and the lid. It contains pogo receptors and magnets.

/* * Variables * */
    
//release base variables
o_h = 17.5; //x
o_w = 6.5; //z
o_d = 13; //y

//release lid variables
o_l_h =14; //z
o_l_w = 3.25; //x
o_l_d = 13; //y

//pogo receptor variables
//Pogo receptor is shaped like two cylinders, a larger one on top of a smaller one
ppr_top_d=3.2; // top cyclinder diameter
ppr_top_r=1.6;
ppr_top_h=1.5; // top cylinder height
ppr_bottom_d=2.1; //bottom cylinder diameter
ppr_bottom_r=1.2;
ppr_bottom_h=2; //bottom cyclinder height
ppr_d=1.2; //distance between pogo receptors

//USB_male variables
um_h = 12;
um_w = 10;
um_d = 4;

/* * Modules * */
module create_release(){

module release_block(){
       rotate([90,0,0]){
            translate([33,0,0]){
                cube(size = [o_h, o_w, o_d], center = false);
            }
        }
  
}; 
//release_block();

module release_void(){
    //fill with all the stuff below to make this code readable
}

module two_pogo_recs(){  
    module pogo_rec(){
        //variables: ppr_top_r, ppr_top_h, ppr_bottom_r, ppr_bottom_h
        module pogo_rec_top(){
            cylinder($fn = 30, $fa = 30, $fs = 2, h=ppr_top_h, r1=ppr_top_r, r2=ppr_top_r, center = false); 
        };
    pogo_rec_top();   
        module pogo_rec_bottom(){
            translate([.05,0,1]){
                rotate([0,0,-18]){
                cylinder($fn = 30, $fa = 30, $fs = 2,h=ppr_bottom_h, r1=ppr_bottom_r, r2=ppr_bottom_r, center = false);
            }
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
        translate([33.25,-16.15,-4.25-zpascifier]){
            magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();
            }
        }
    }
//release_magnet();
    difference(){
        release_block();
        release_magnet();
    }
}

//release_subtract_magnet();

module subtract_usb_m(){
    module usb_male(){
    translate([35.5,-10,1]){
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

    module create_pogo_recs(){
        color("yellow") 
            translate([39.5,-10,2.1]){
            rotate([0,0,0]){
                two_pogo_recs(); 
                 }
              }
         }
     
    // create_pogo_recs();
module subtract_receptors(){

        difference(){
            subtract_usb_m();
    create_pogo_recs();
            }
        
    }

        
//subtract_receptors();
    module screw(){
        cylinder($fn = 30, $fa = 30, $fs = 2,h=s_h, r1=s_r1, r2=s_r2, center = false);
    }
    
      module two_screws(){
        translate([-.7,-7.5,0]){
        screw();
    }

    translate([14.1,-7.5,0]){
        screw();
        }
    } 
   
//two_screws(); 

module make_screw_tops_release(){    

    translate([35,3,0]){
        two_screws(); //for release base
    }

    translate([10,3,3]){
        two_screws(); // for release lid
    }
};
//make_screw_tops_release();

module subtract_screw_tops_release(){
    difference(){
    subtract_receptors();
    make_screw_tops_release();
}
}
//subtract_screw_tops_release();

module make_nuts_release(){
  module nut_release(){
        translate([32.5,-4.5,1.5]){
            rotate([90,90,0]){
                cube(size=[n_h,n_l*1.25,n_h], center = false);
            }
        }
    }
  nut_release(); //make one nut
    translate([n_d/1.5,0,0]){
      nut_release(); //make one nut n_d distance from the first nut
    }
}

//make_nuts_release(); //two nuts

module subtract_nuts_release(){
    difference(){
        subtract_screw_tops_release();
        make_nuts_release();
       translate([0,1.25,0]) make_nuts_release();
    }
}
//subtract_nuts_release();


module cut_away_lid(){
   //cut block
        module cut_release_block(){

            translate([33-zpascifier,zpascifier,o_d/4-zpascifier]){
                rotate([90,0,0]){
                    cube(size = [o_h+zpascifier*2, o_w+zpascifier*2, o_d+zpascifier*2+4], center = false);
            }
        }

}; 

// cut away release lid
difference(){
    subtract_nuts_release();
    cut_release_block();
    }
}
color("blue",.8){
    cut_away_lid();
} //is the base


module create_release_lid(){
{
    translate([-25,0,0])cut_away_lid();
}
}

color("lightblue"){
    create_release_lid();
}

module create_release_m(){

    //block
    module release_block(){
        color("aquamarine",.55)
        translate([0,-20,0])  rotate([90,0,0]){
            translate([33,0,0]){
                cube(size = [o_h, o_w/4, o_d], center = false);
            }
        }  
    }


difference(){
    release_block();
     void();
       
}//cut pogos
        
 

module void(){
    translate([35.5,-28,-zpascifier]) cube(size = [um_h, um_w, um_d], center = false);  //cut usb
                    translate([33.25,-36.15,-6-zpascifier]){
            magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();           
            }
        }//cut magnets
translate([40,-31,2.5-zpascifier]) two_pogo_recs(); 
translate([40,-31,-.8-zpascifier]) two_pogo_recs();// cut pogo recs
translate([35,-16,0]) two_screws();
}

//void();

};



create_release_m();

}
//create_release();

     


/* * * RENDER ALL THE PARTS * * */

module create_all(){

//render breakaway lid
   create_breakaway_lid();

//render breakaway base
   create_breakaway();
    
//render breakaway midpiece
create_breakaway_m();    

//render release lid
  // create_release_lid(); 

 //render release base   
  create_release();
    
//render release midpiece
//create_release_m();    
    
}
create_all();

/* * * RENDER AN INDIVIDUAL PART * * */

//create_breakaway();
//create_breakaway_lid();
//create_breakaway_m();
//create_release();
//create_release_lid();
//create_release_m();

//translate([25,0,0]){create_breakaway();}

//translate([-25,0,0]){create_release();}

}

main();
