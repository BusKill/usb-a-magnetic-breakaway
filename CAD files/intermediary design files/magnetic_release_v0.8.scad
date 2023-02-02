/*

__________ ____ ___  _____________  __.___.____    .____     
\______   \    |   \/   _____/    |/ _|   |    |   |    |    
 |    |  _/    |   /\_____  \|      < |   |    |   |    |    
 |    |   \    |  / /        \    |  \|   |    |___|    |___ 
 |______  /______/ /_______  /____|__ \___|_______ \_______ \
        \/                 \/        \/           \/       \/


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

The "breakaway" receives the USB from the USB cable with a female USB port. It is in four parts, the base, two middle pieces, and the lid. It contains 4 pogo pins and 2 magnets. It separates from the release when the cord is pulled.

The "release" is attached to a cord ending in a male USB. It is in three parts, the base, the middle, and the lid. It contains 4 pogo receptors and 2 magnets.

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

/* * Screw and Nut * */
s_h=7; // screw length
s_r1=.75; // screw shaft radius
s_r2=2; // screw top radius
n_l=6; //nut channel length
n_h=1.25; //nut height
n_d=14; //distance between nuts
s_d_r=13; //distance between screws release
s_d_b=13; //distance between screws breakaway

/*
__________       .__                               
\______   \ ____ |  |   ____ _____    ______ ____  
 |       _// __ \|  | _/ __ \\__  \  /  ___// __ \ 
 |    |   \  ___/|  |_\  ___/ / __ \_\___ \\  ___/ 
 |____|_  /\___  >____/\___  >____  /____  >\___  >
        \/     \/          \/     \/     \/     \/ 

*/

/* * * Create Release * * */

//The "release" plugs into the computer with a male USB. It is in two parts, the base and the lid. It contains pogo receptors and magnets.

/* * Variables * */
    
//release base variables
o_h = 22; //x
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

//pogo receptor
module two_pogo_recs(){  
    module pogo_rec(){
        //variables: ppr_top_r, ppr_top_h, ppr_bottom_r, ppr_bottom_h
        module pogo_rec_top(){
            translate([39.5,3,10])cylinder($fn = 30, $fa = 30, $fs = 2, h=ppr_top_h, r1=ppr_top_r, r2=ppr_top_r, center = false); 
        };
    pogo_rec_top();   
        module pogo_rec_bottom(){
            translate([39.5,3,10])translate([.05,0,1]){
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

//USB_male variables
um_h = 13;
um_w = 10;
um_d = 4;

/* * Modules * */


module release_block(){
       rotate([90,0,0]){
            translate([30,0,0]){
                cube(size = [o_h, o_w, o_d], center = false);
            }
        }
  
}; 
//release_block();


    module release_magnet(){
        translate([33,-16.15,-4.25-zpascifier]){
            magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();
            }
        }
    }
//release_magnet();
    
        module usb_male(){
    translate([35.5,-10,1]){
        cube(size=[um_h,um_w,um_d], center = false);
    }
}
//usb_male();

//Screws
    module screw(){
        translate([-1.6,0,0])cylinder($fn = 30, $fa = 30, $fs = 2,h=s_h, r1=s_r1, r2=s_r2, center = false);
    };
    //screw();
    
    module two_screws(){
        translate([-1,-7.5,0]){
        screw();
    }

    translate([16.5,-7.5,0]){
        screw();
        }
    }; 
   
//two_screws(); 

module two_top_screws(){    

    translate([35,3,0]){
        two_screws(); //for release base
    }
};
//two_top_screws();
module two_bottom_screws(){    

    translate([10,3,3]){
        two_screws(); // for release lid
    }
};
//two_bottom_screws; 

//Nuts
module two_nuts(){
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
};

//two_nuts(); 
module release_top_block(){
    release_block();
    
}

//release_top_block();

module release_top_void(){
    two_pogo_recs();
    release_magnet();
    usb_male();
    two_top_screws();
    two_nuts();
    translate([30,0,3.7])rotate([90,0,0])cube(size = [o_h+1, .3*o_w+1, o_d+1], center = false);
}
//release_top_void();

//create release top
 module create_release_top(){
     
   color("lightblue") difference(){
        release_top_block();
        release_top_void();
    }
}
//create_release_top();

//create release base

module release_base_block(){
        color("blue") translate([-30,0,0])release_block();
    
};
//release_base_block();

module release_base_void(){
translate([-30,0,0])release_top_void();
    
}
//release_base_void();

module create_release_base(){
 difference(){
        release_base_block();
        release_base_void();
    }
//create_release_base();



module create_release_m(){

    //block
    module release_block(){
        color("aquamarine",.55)
        translate([0,-20,0])  rotate([90,0,0]){
            translate([30,0,0]){
                cube(size = [o_h, o_w/2.5, o_d], center = false);
            }
        }  
    }


difference(){
    release_block();
     void();
       
}
//cut pogos
        
 

module void(){
    translate([35,-28,-zpascifier]) cube(size = [um_h, um_w, um_d], center = false);  //cut usb
                    translate([33,-36.15,-6-zpascifier]){
            magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();           
            }
        }//cut magnets
translate([0,-20,-2-zpascifier]) two_pogo_recs(); 
translate([35,-16,-1]) two_screws();
}

//void();

};



create_release_m();

}

module create_release(){
create_release_top();
create_release_base();
create_release_m();
    
}

//create_release();


/*  

\______   \_______   ____ _____  |  | _______ __  _  _______  ___.__.
 |    |  _/\_  __ \_/ __ \\__  \ |  |/ /\__  \\ \/ \/ /\__  \<   |  |
 |    |   \ |  | \/\  ___/ / __ \|    <  / __ \\     /  / __ \\___  |
 |______  / |__|    \___  >____  /__|_ \(____  /\/\_/  (____  / ____|
        \/              \/     \/     \/     \/             \/\/     

*/

/* * * Create Breakaway * * */
 
 //The "breakaway" receives the USB from the USB cable with a female USB port. It is in two parts, the base and the lid. It contains pogo pins and magnets.

/* * Variables * */

//breakaway base variables
i_h = 20; //x
i_w = 2.5; //z
i_d = 24; //y
 
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

//cut_female variables
cf_h = 21; //the width for some reason
cf_w = 13; //the height 
cf_d = 5.75; // the same as cf_w for some reason... 

//pogo variables
//pogo pins are shaped like a cylinder.

pogo_length=12;
pogo_tip_diameter=1;
pogo_diameter=1.25;
pogo_distance=3.5+zpascifier; //distance between pins (x=z)

/* * Breakaway Blocks * */


/* * Breakaway Void */

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

/* * Magnet * */

module breakaway_magnet(){
        translate([52.5,-27.17,-5]){
            magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();
            }
        }
    }
//breakaway_magnet();
    
        module void(){
        translate([97.5,-13.1,1.625]){
            pogo_pin();
            } //subtract pogo_pin
        translate([90.5,-27.17,-5]){
            magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();
            } //subtract magnets
        }         
              module screw(){translate([90,0,0])
        cylinder($fn = 30, $fa = 30, $fs = 2,h=s_h, r1=s_r1, r2=s_r2, center = false);
        translate([100,0,0])cylinder($fn = 30, $fa = 30, $fs = 2,h=s_h, r1=s_r1, r2=s_r2, center = false);
    }
  translate([3.5,0,1]){
        screw();
    }
  
    };
    //void();

module create_breakaway_top(){
    void();
};
    
//create_breakaway_top();

module create_breakaway_base(){
   translate([40,0,0]) void();
};
//create_breakaway_base();

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

/*

 _______   ________  __    __  _______   ________  _______  
/       \ /        |/  \  /  |/       \ /        |/       \ 
$$$$$$$  |$$$$$$$$/ $$  \ $$ |$$$$$$$  |$$$$$$$$/ $$$$$$$  |
$$ |__$$ |$$ |__    $$$  \$$ |$$ |  $$ |$$ |__    $$ |__$$ |
$$    $$< $$    |   $$$$  $$ |$$ |  $$ |$$    |   $$    $$< 
$$$$$$$  |$$$$$/     $$ $$ $$ |$$ |  $$ |$$$$$/    $$$$$$$  |
$$ |  $$ |$$ |_____ $$ |$$$$ |$$ |__$$ |$$ |_____ $$ |  $$ |
$$ |  $$ |$$       |$$ | $$$ |$$    $$/ $$       |$$ |  $$ |
$$/   $$/ $$$$$$$$/ $$/   $$/ $$$$$$$/  $$$$$$$$/ $$/   $$/


*/


/* * * RENDER ALL THE PARTS * * */

module create_all(){

//render breakaway top
   create_breakaway_top();

//render breakaway base
   create_breakaway_base();
    
//render breakaway midpiece
create_breakaway_m();    

//render release lid
  create_release_top(); 

 //render release base   
  create_release_base();
    
//render release midpiece
create_release_m();    
    
}
create_all();

/* * * RENDER AN INDIVIDUAL PART * * */

//create_breakaway();
//create_breakaway_base();
//create_breakaway_top();
//create_breakaway_m();


//create_release();
//create_release_base();
//create_release_top();
//create_release_m();


}

main();
