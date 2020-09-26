$fn=20;
/*
  Pogo Pin Serial Adaptor (Customisable)
  Author: Brian Khuu 2019
  
  This is similar to https://hackaday.com/2017/08/04/pogo-pin-serial-adapter-thing/
  But is fully 3D printed without need for PCB. This may be useful for Arduino serial adaptors.
  
  I used P100-E2 probes for this
*/

// Designed For Printer Nozzle
printer_nozzle=0.4;

// Base Thickness
base_thickness = 0.1;

/* probe pin spec */
ppext = 6.8; // Probe extention length
ppbody = 14; // Body of the probe
ppdia = 1.5; // probe pin diameter

ppdiatol = 0.6; // tolerance for fitting
ppinset = 2.5;

ppdiaoutset = ppext-ppinset; // How far to space out to allow for side fits
echo(ppdiaoutset);

/* Castellated Module Pin Spacing and count */

// Pin Count
ppc = 2;

// Pin Spacing
pps = 2.54;

// PCB Thickness
pcb_thickness = 1.1; // 1mm Open Log Clone

// PCB Probe Offset
pcb_probe_offset = 1.3;

/* Clip */
clip_tab = 5; // Clip tab to more easily open the clip

/* pcb */
pcb_h = 2; // pcb thickness

/* calc */
boxx = ppc * pps + ppdia;
boxy = 2 + ppbody + ppdiaoutset;
boxh = base_thickness+pcb_probe_offset+ppdiatol+5;

module probe_pin_req()
{
  inset=0;
  translate([0,0,-ppbody])
  union()
  {
    translate([0,0,0])
      cylinder(r1=(ppdia)/2,r2=(ppdia+ppdiatol)/2, h=3);
    translate([0,0,1])
      cylinder(r=(ppdia+ppdiatol)/2, h=ppbody+ppext+1);
    %color("gold") cylinder(r=ppdia/2, h=ppbody);
    %color("silver") translate([0,0,ppbody])
      cylinder(r=ppdia/2, r2=0, h=ppext);
  }
}

module openlog_clone_programmer_jig()
{
  difference()
  {  
    /* Bulk */
    union()
    {
      difference()
      {
        cube([boxx,boxy,boxh]);
        translate([-5, 0, base_thickness+pcb_probe_offset+ppdia*1.5]) 
          cube([ppc * pps+10,ppbody, 5]);
      }
      translate([-(ppdia)/2, ppdiaoutset+7+ppbody/2, 0]) 
        cube([boxx+(ppdia),boxy-(ppdiaoutset+7+ppbody/2), boxh]);
      translate([-(ppdia)/2, ppdiaoutset, 0]) 
        cube([boxx+(ppdia),7, 5]);
    }

    /* Probe Access Cutout */
    translate([-5, ppdiaoutset+7, base_thickness+pcb_probe_offset+ppdia/2]) 
      cube([ppc * pps+10,ppbody/2, boxh]);
      
    /* Module Cutout */
    translate([0, -0.001, base_thickness+ppdia+ppdiatol]) 
      cube([boxx,ppdiaoutset, boxh]);
      
    /* Probe */
    for ( xi = [0 : 1 : ppc-1] )
    {
      translate([ppdia/2+pps/2+pps*xi, 0, base_thickness])
      union()
      {
        translate([0, ppdiaoutset, pcb_probe_offset+ppdiatol])
          rotate([90,0,0])
          probe_pin_req();
        
        translate([0, ppdiaoutset, pcb_probe_offset+ppdiatol])
          rotate([180,0,0])
            translate([0, (ppdiaoutset)/2, 0])
              cube([ppdia+ppdiatol,(ppdiaoutset),ppdia+1], center=true);
      }
    }
    
    /* Wire Guide (To solder onto the probe) */
    for ( xii = [0 : 1 : ppc-1] )
    {
      translate([ppdia/2+pps/2+pps*xii, boxy+1, base_thickness+ppdia+1.5+pcb_probe_offset+ppdiatol])
        rotate([95,0,0])
          cube([2,2.5,20],center=true);
    }
  }
}

openlog_clone_programmer_jig();