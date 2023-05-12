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

The "breakaway" is connected to a USB extension cord that terminates with the female USB port that receives a USB. It is in four parts, the base, two middle pieces, and the lid. It contains 5 pogo pins and 2 magnets. It separates from the release when the cord is pulled.

The "release" is connected to the cord that terminates with the male USB and inserts the computer. It is in three parts, the base, the middle, and the lid. It contains 5 pogo receptors and 2 magnets.

The middle pieces are created in order to stabilize the pogo pins and magnets from the top and bottom pieces to keep them from interfering with each other.

When the magnets on the breakaway and release connect, the pogo pins and pogo receptors must meet and establish the USB connection.

The breakaway and release plugs must be designed asymmetrically to prevent the connection from happening the wrong way. 

The case must be designed so that the user can completely dissemble it and ensure there has been no tampering. No glue must be required. The base and lid connect together with tiny screws and embedded nuts. There will be a middle wall piece for both ends that separates top and bottom components.

The magnets are a custom hexagonal shape so that they can connect at the flat surface and be held in place by the plastic without requiring glue. The engineering document is available on the repo.

docs.buskill.in
buskill.in
*/


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

module M3HexNut() {
  height = 6;
  size = 3.2;
  sides = 6;
  translate([0, 0, -height/2]) 
      cylinder(d=size, h=height, center=true);
    
}

//M3HexNut();


module M3Screw() {
s_h =7; // screw length
s_r1 = 1; // screw shaft radius
s_r2 = 2; // screw top radius

// create the screw body
cylinder(r = s_r1, h = 8, center = true);

// create the screw head
translate([0, 0, s_h - s_r2]) {
cylinder(r = s_r2, h = s_r2, center = true);
}
}
//M3Screw();

/*
__________       .__                               
\______   \ ____ |  |   ____ _____    ______ ____  
 |       _// __ \|  | _/ __ \\__  \  /  ___// __ \ 
 |    |   \  ___/|  |_\  ___/ / __ \_\___ \\  ___/ 
 |____|_  /\___  >____/\___  >____  /____  >\___  >
        \/     \/          \/     \/     \/     \/ 

*/

/* * * Create Release * * */

// The "release" is connected to the cord that terminates with the male USB and inserts the computer. It is in three parts, the base, the middle, and the lid. It contains 5 pogo receptors and 2 magnets.(blue)

/* * Variables * */
    
//release block variables
o_h = 24; //x
o_w = 6; //z
o_d = 20; //y


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
um_h = 14;
um_w = 15;
um_d = 6;

/* * Modules * */


module release_block(){
       rotate([90,0,0]){
            translate([30,0,-8]){
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
    
        module usb_female(){
    translate([35,-6,1]){
        cube(size=[um_h,um_w,um_d], center = false);
    }
}
//usb_female();


module release_top_block(){
    release_block();
    
}

//release_top_block();

module release_top_void(){
    mag_position=-2;
    translate([0,1,-3])two_pogo_recs();
    translate([.5,0,mag_position])release_magnet();
    translate([0,0,-5])usb_female();
   
}
//release_top_void();

//create release top
 module create_release_top(){
     
   color("lightblue") difference(){
        release_top_block();
        release_top_void();
       translate([32.5,5,0])M3Screw();translate([51,5,0])M3Screw(); 
    }
}
//create_release_top();

//create release base

module release_base_block(){
        color("blue") translate([-30,0,0])release_block();
    
};
//release_base_block();

module release_base_void(){
translate([-30,1,1])two_pogo_recs();
    translate([-29.5,.3,.5])release_magnet();
    translate([-30,0,0])usb_female();
    
}
//release_base_void();

module create_release_base(){
 difference(){
        release_base_block();
        release_base_void();
     translate([2.5,5.5,4.75])M3HexNut();translate([21.5,5.5,4.75])M3HexNut(); 
    }
}
//create_release_base();


module create_release_m(){

    //block
    module release_block(){
        color("aquamarine",.55)
        translate([0,-20,0])  rotate([90,0,0]){
            translate([30,0,0]){
                cube(size = [o_h, o_w, o_d], center = false);
            }
        }  
    }   

module mid_void(){
    mag_top_h=-3.75;
    mag_bottom_h=mag_top_h-3;
    
    
    translate([35,-32,-zpascifier]) cube(size = [um_h, um_w, um_d], center = false);  //cut usb
                    translate([33.5,-43.25,mag_top_h]){
            magnet();
                    {
            translate([magnet_distance,0,-zpascifier]){
                magnet();           
            }}
        }
        
        translate([33.5,-43.25,mag_bottom_h]){
            magnet();
                    {
            translate([magnet_distance,0,-zpascifier]){
                magnet();           
            }}
        }
        
        //cut magnets
        
   rec_top_h=.75;
   rec_bottom_h=rec_top_h-3.5;
        
translate([0,-27,rec_top_h]) two_pogo_recs(); 
translate([0,-27,rec_bottom_h]) two_pogo_recs(); 
translate([32.5,-22.5,4.75])M3HexNut();translate([51.75,-22.5,4.75])M3HexNut(); 
}


//mid_void();

difference(){
    release_block();
     mid_void();
       
}

};

//create_release_m();



module create_release(){
create_release_top();
create_release_base();
create_release_m(); 
}

//create_release();


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

/* * Variables * */

//breakaway base variables
i_h = 20; //x
i_w = 12; //z
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

//pogo variables
//pogo pins are shaped like a cylinder.

pogo_length=12;
pogo_tip_diameter=1;
pogo_diameter=1.75;
pogo_distance=3.8+zpascifier; //distance between pins (x=z)

/* * Breakaway Blocks * */
    module top_block(){
    color("Red",.55)
    translate([56.1,-12,0])  rotate([90,0,0]){
            translate([33,.5,0]){
                cube(size = [i_l_h, i_l_w/3, i_l_d/2], center = false);
            }
        } 
    } 
  //  top_block();
    
        module base_block(){
    color("Pink",.55)
    translate([96.1,-12,-.5])  rotate([90,0,0]){
            translate([33,0,0]){
                cube(size = [i_l_h, i_l_w/3, i_l_d/2], center = false);
            }
        } 
    } 
   // base_block();
    
    module mid_block(){
    color("DeepPink",.55)
    translate([46,-30,-.5])  rotate([90,0,0]){
            translate([33,0,0]){
                cube(size = [i_l_h, i_l_w/3, i_l_d/2], center = false);
            }
        } 
    }
//mid_block();    

/* * Breakaway Top and Base Void */

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
        translate([97.25,-12.1,4]){
            pogo_pin();
            } //subtract pogo_pin
        translate([91,-27.15,-3]){
            magnet();
            translate([magnet_distance,0,-zpascifier]){
                magnet();
            } //subtract magnets
        }         
    };
    //void();

module create_breakaway_top(){
    difference(){
    top_block();
    translate([0,0,0])void();
    }
};
 
//create_breakaway_top();

//Base

module create_breakaway_base(){
    difference(){
   base_block();
     translate([39.5,0,-.5])void();
    }
};
//create_breakaway_base();

module create_breakaway_m(){
    
    //block

/* Breakaway Mid Void */

// unlike the base and lid voids, this void has the bottom of base pogo pin and the top of the lid pogo pins, allowing for the pins to be in place during assembly
    
    module void(){
        
        mag_top_h=-4;
        mag_bottom_h= mag_top_h-3;
        
        translate([1,0,0]){
        translate([86,-31,.4]) pogo_pin();
        translate([86,-31,4]) pogo_pin();  
   
        

   translate([79.5,-45.25,mag_top_h]){
            magnet();
                    {
            translate([magnet_distance,0,0]){
                magnet();           
            }}
        }
        
        translate([79.5,-45.25,mag_bottom_h]){
            magnet();
                    {
            translate([magnet_distance,0,0]){
                magnet();           
            }}
        }
              

    }
}
        difference(){
        mid_block();
        void();
     
    }
       // void();
}

module create_breakaway(){
    create_breakaway_m();
    create_breakaway_base();
    create_breakaway_top();
}
//create_breakaway();

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

create_breakaway();
create_release();  
    
}
//create_all();

/* * * RENDER AN INDIVIDUAL PART * * */

create_breakaway();
//create_breakaway_base();
//create_breakaway_top();
//create_breakaway_m();


//create_release();
//create_release_base();
//create_release_top();
//create_release_m();

/* * * MODEL ASSEMBLY * * */

module model_breakaway(){

translate([238,2.5,0])rotate([90,0,180])create_breakaway_top();
translate([50,10.75,18])rotate([90,0,0])create_breakaway_m(); 
    translate([0,15,0])rotate([90,0,0])create_breakaway_base();
    
}
//model_breakaway();

module model_release(){
translate([0,14,2])rotate([90,0,0])create_release_base();
translate([-30,6,2])rotate([90,0,0])create_release_top();
translate([-30,10,30])rotate([90,0,0])create_release_m();
}
//model_release();

}

main();
