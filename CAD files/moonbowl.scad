for (i=[0:100])
   scale(1.25)rotate([i,0,])translate([0,0,1]){linear_extrude(height = 10, center = true)

{
    import("/home/goldishlaser/Pictures/moonbowl.svg");
    }
}