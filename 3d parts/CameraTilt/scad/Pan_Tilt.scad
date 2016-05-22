use <fillets.scad>

// Based on http://www.thingiverse.com/thing:115972

$fn=50;
fudge=0.1;


servo_arm_hub_radi=7.7/2;
servo_arm_hub_radi2 = servo_arm_hub_radi - 1;
servo_arm_hub_height=4.30;
servo_arm_hub_center_hole_radi=2.4/2;
servo_arm_hub_center_countersink_radi=6/2;
servo_arm_hub_center_countersink_height=0;

servo_arm_tip_radi=4/2;
servo_arm_tip_height=3;
servo_arm_length=26.42;
servo_arm_centerhubtooutterpin=19.49-2*servo_arm_tip_radi-servo_arm_tip_radi;
servo_arm_pin_spacing=9/3;
servo_arm_pin_hole_radi=1.5/2;
servo_arm_fudge_factor=.2;

servo_drive_pin_radi=4.7/2;
servo_drive_pin_height=3.0;

servo_plate_len = 31.8;
servo_plate_width = 12.5;
servo_plate_thickness = 2.5;
servo_plate_screw_radi = 2/2;
servo_plate_screw_distance = 27.7;
servo_plate_screw_offset = (servo_plate_len - servo_plate_screw_distance)/2;
servo_plate_internal_len = 23;


camera_holder_arm_thickness=6.0;
camera_holder_arm_servo_hub_radi=18.5/2;
camera_holder_plate_offset=35;
camera_holder_plate_width=46+(2*camera_holder_arm_thickness);
camera_holder_plate_height=33;
camera_holder_plate_thickness=6;
camera_holder_plate_Attachment_bracket_x=15;
camera_holder_plate_Attachment_bracket_z=3 ;
camera_holder_plate_Attachment_bracket_screw_radi=3.55/2;
camera_holder_plate_Attachment_bracket_screw_nut_size=6.60/2;
camera_holder_plate_Attachment_bracket_screw_offset=9.5;

camera_holder_plate_Attachment_bracket_screw_head_radi=6.5/2;
camera_holder_plate_Attachment_bracket_screw_head_height=3.5;


Plate_Height=4.0;
Plate_Corner_Radi=4;
Plate_X_Size=48;
Plate_Y_Size=48;
Plate_Hole_Radi=3.2/2;

servo_hight = 21.4;

//exploded_view();

//new_exploded_view();

//new_cam_holder();
servo_bracket();
//camera_holder_arm_w_servo_cutout();

//camera_holder_no_cutout();

//camera_holder_arm_w_bearing_cutout();
//camera_holder_arm_w_servo_hub_cutout();

/*
translate([0,0,camera_holder_plate_thickness])
rotate([180,0,0])
camera_holder_plate();
*/

//lower_pivot_bearing_holder();

//upper_pivot_bearing_holder();

//mounting_plate();

//##########################################################
//##########################################################
// Test Stuff Below....
//##########################################################
//##########################################################

//servo_arm(0);
//color("red") translate([10,0,0]) servo_arm_negative();
//camera_holder();

//color("blue")
   //servo();
//MakePlate();

//fil_linear_o(20,2);

//##########################################################
//##########################################################


//##########################################################
module mounting_plate () {
//##########################################################

   mount_height=32;

   difference() {
   union() {
       MakePlate();

     hull() {
      translate([0,10,0])
       cylinder(r=7/2,h=mount_height);
      translate([0,38,0])
       cylinder(r=7/2,h=mount_height);
     }

     hull() {
      translate([Plate_Y_Size,10,0])
       cylinder(r=7/2,h=mount_height);
      translate([Plate_Y_Size,38,0])
       cylinder(r=7/2,h=mount_height);
     }

     hull() {
      translate([0,10,0])
       cylinder(r=7/2,h=mount_height);
      translate([Plate_Y_Size,10,0])
       cylinder(r=7/2,h=mount_height);
     }

     hull() {
      translate([0,38,0])
       cylinder(r=7/2,h=mount_height);
      translate([Plate_Y_Size,38,0])
       cylinder(r=7/2,h=mount_height);
     }

   }

   // Screw Holes
   translate([-.1,19,-fudge+15])
      cylinder(r=3/2,h=20);

   translate([-.1,29,-fudge+15])
      cylinder(r=3/2,h=20);

   translate([48.1,19,-fudge+15])
      cylinder(r=3/2,h=20);

   translate([48.1,29,-fudge+15])
      cylinder(r=3/2,h=20);

   hull() {
   translate([-6.2,Plate_Y_Size/2,7.5])
   rotate([0,90,0])
   cylinder(r=3,h=10);

   translate([-6.2,Plate_Y_Size/2,24])
   rotate([0,90,0])
   cylinder(r=3,h=10);

   }

   hull() {
   translate([44.4,Plate_Y_Size/2,7.5])
   rotate([0,90,0])
   cylinder(r=3,h=10);

   translate([44.4,Plate_Y_Size/2,24])
   rotate([0,90,0])
   cylinder(r=3,h=10);

   }

   translate([Plate_Y_Size/2,13.8,31])
   rotate([90,90,0])
   cylinder(r=20.5,h=10,$fn=200);

   translate([Plate_Y_Size/2,44.2,31])
   rotate([90,90,0])
   cylinder(r=20.5,h=10,$fn=200);


   }


}


//##########################################################


//##########################################################
module exploded_view (angle=0)
//##########################################################
{

    color("Purple")
    translate([camera_holder_plate_width,camera_holder_plate_height/2,
           camera_holder_plate_Attachment_bracket_z+camera_holder_plate_thickness])
        rotate([0,-90,0])
            camera_holder_arm_w_servo_cutout();

    color("Purple")
    translate([0,camera_holder_plate_height/2,
           camera_holder_plate_Attachment_bracket_z+camera_holder_plate_thickness])
         rotate([0,-90,180])
            camera_holder_arm_w_bearing_cutout();

    color("green")
    translate([0,camera_holder_plate_height,camera_holder_plate_thickness])
         rotate([180,0,0])
            camera_holder_plate();

    translate([camera_holder_plate_width-5.5,camera_holder_plate_height/2,camera_holder_plate_offset+camera_holder_plate_thickness+camera_holder_plate_Attachment_bracket_z])
    rotate([0,90,0])
    union() {
        color("Blue")
        servo_arm(0);
        rotate([0,0,angle])
        color("yellow")
        servo();
    }

    color("LightBlue")
    translate([-3.7,camera_holder_plate_height/2,camera_holder_plate_offset+camera_holder_plate_thickness+camera_holder_plate_Attachment_bracket_z])
    rotate([0,90,0])
    upper_pivot_bearing_holder();

    color("LightBlue")
    translate([6.5,camera_holder_plate_height/2,camera_holder_plate_offset+camera_holder_plate_thickness+camera_holder_plate_Attachment_bracket_z])
    rotate([0,-90,0])
    lower_pivot_bearing_holder();

}

//##########################################################
module camera_holder_plate()
//##########################################################
{

    hole1_2_x=camera_holder_plate_Attachment_bracket_z+(camera_holder_arm_thickness/2+.5);
    hole1_3_y=(camera_holder_plate_height/2)-camera_holder_plate_Attachment_bracket_screw_offset;
    hole2_4_y=(camera_holder_plate_height/2)+camera_holder_plate_Attachment_bracket_screw_offset;

    hole3_4_x=camera_holder_plate_width-(camera_holder_plate_Attachment_bracket_z+(camera_holder_arm_thickness/2+.5));

    difference() {
        cube([camera_holder_plate_width,
              camera_holder_plate_height,
              camera_holder_plate_thickness]);

        // Four screw holes
        translate([hole1_2_x,hole1_3_y,-fudge])
            cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,
                     h=camera_holder_plate_thickness+(2*fudge));

        translate([hole1_2_x,hole2_4_y,-fudge])
            cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,
                     h=camera_holder_plate_thickness+(2*fudge));

        translate([hole3_4_x,hole1_3_y,-fudge])
            cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,
                     h=camera_holder_plate_thickness+(2*fudge));

        translate([hole3_4_x,hole2_4_y,-fudge])
            cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,
                     h=camera_holder_plate_thickness+(2*fudge));

        // Four screw countersinks
        translate([hole1_2_x,hole1_3_y,-fudge])
            cylinder(r=camera_holder_plate_Attachment_bracket_screw_head_radi,
                     h=camera_holder_plate_Attachment_bracket_screw_head_height+(2*fudge));
        translate([hole1_2_x,hole2_4_y,-fudge])
            cylinder(r=camera_holder_plate_Attachment_bracket_screw_head_radi,
                     h=camera_holder_plate_Attachment_bracket_screw_head_height+(2*fudge));
        translate([hole3_4_x,hole1_3_y,-fudge])
            cylinder(r=camera_holder_plate_Attachment_bracket_screw_head_radi,
                     h=camera_holder_plate_Attachment_bracket_screw_head_height+(2*fudge));
        translate([hole3_4_x,hole2_4_y,-fudge])
            cylinder(r=camera_holder_plate_Attachment_bracket_screw_head_radi,
                     h=camera_holder_plate_Attachment_bracket_screw_head_height+(2*fudge));


     }

tab_offset=10;
tab_height=42;

     hull() {
     translate([camera_holder_plate_width/2+tab_offset,8,0])
     rotate([180,0,0])
     cylinder(r=4,h=tab_height);
     translate([camera_holder_plate_width/2-tab_offset,8,0])
     rotate([180,0,0])
     cylinder(r=4,h=tab_height);
     }
}



//##########################################################
module camera_holder_arm_w_bearing_cutout ()
//##########################################################
{

   translate([0,0,camera_holder_arm_thickness])
   rotate([0,90,0])
   union() {
   difference() {
       union() {
	    // Camera Holder Arms
        hull() {
            translate([0,0,camera_holder_plate_offset])
                rotate([0,90,0])
                     cylinder(r=camera_holder_arm_servo_hub_radi,
                              h=camera_holder_arm_thickness);
            translate([0,-camera_holder_plate_height/2,0])
                cube([camera_holder_arm_thickness,camera_holder_plate_height,1]);
        }
        // Plate Attachment bracket
        translate([-camera_holder_plate_Attachment_bracket_x+camera_holder_arm_thickness,
                   -camera_holder_plate_height/2,
                   -camera_holder_plate_Attachment_bracket_z+fudge])
        cube([camera_holder_plate_Attachment_bracket_x,
               camera_holder_plate_height,
               camera_holder_plate_Attachment_bracket_z]);
        }

        //translate([-fudge,0,camera_holder_plate_offset])
        //rotate([0,90,0])
        //servo_arm_negative();

        //translate([camera_holder_arm_thickness-2+fudge-.3,0,camera_holder_plate_offset])
        //rotate([0,90,0])
        //cylinder(r=14.5/2+fudge,h=2+.3+fudge);

        translate([camera_holder_arm_thickness-3+fudge,0,camera_holder_plate_offset])
        rotate([0,90,0])
        cylinder(r=10.5/2+fudge,h=3+fudge);

        translate([-fudge,0,camera_holder_plate_offset])
        rotate([0,90,0])
        cylinder(r=12.12/2+fudge,h=2.75+(4*fudge));

        translate([-fudge,0,camera_holder_plate_offset/2-4])
        rotate([0,90,0])
        cylinder(r=22/2+fudge,h=camera_holder_arm_thickness+(4*fudge));

        // Plate Attach screw Holes 
        translate([-(camera_holder_plate_Attachment_bracket_x-camera_holder_arm_thickness)/2,
                   camera_holder_plate_Attachment_bracket_screw_offset,
                   -camera_holder_plate_Attachment_bracket_z])
        cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,
                 h=camera_holder_plate_Attachment_bracket_z+(2*fudge));
        translate([-(camera_holder_plate_Attachment_bracket_x-camera_holder_arm_thickness)/2,
                   -camera_holder_plate_Attachment_bracket_screw_offset,
                   -camera_holder_plate_Attachment_bracket_z])
        cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,
                 h=camera_holder_plate_Attachment_bracket_z+(2*fudge));

        translate([-(camera_holder_plate_Attachment_bracket_x-camera_holder_arm_thickness)/2,
                   camera_holder_plate_Attachment_bracket_screw_offset,
                   -2])
        rotate([0,0,30])
        cylinder(r=camera_holder_plate_Attachment_bracket_screw_nut_size,
                 h=2+(2*fudge),$fn=6);

        translate([-(camera_holder_plate_Attachment_bracket_x-camera_holder_arm_thickness)/2,
                   -camera_holder_plate_Attachment_bracket_screw_offset,
                   -2])
        rotate([0,0,30])
        cylinder(r=camera_holder_plate_Attachment_bracket_screw_nut_size,
                 h=2+(2*fudge),$fn=6);


    }

        //translate([camera_holder_arm_thickness-2-.1,0,camera_holder_plate_offset])
        //rotate([0,90,0])
        //#cylinder(r=14/2+fudge,h=.2);
    }

}


module camera_holder_no_cutout () {
    

   translate([0,0,camera_holder_arm_thickness])
   rotate([0,90,0])
   difference() {
       union() {
	    // Camera Holder Arms
        hull() {
            translate([0,0,camera_holder_plate_offset])
                rotate([0,90,0])
                     cylinder(r=camera_holder_arm_servo_hub_radi,
                              h=camera_holder_arm_thickness);
            translate([0,-camera_holder_plate_height/2,0])
                cube([camera_holder_arm_thickness,camera_holder_plate_height,1]);
        }
        // Plate Attachment bracket
        translate([-camera_holder_plate_Attachment_bracket_x+camera_holder_arm_thickness,
                   -camera_holder_plate_height/2,
                   -camera_holder_plate_Attachment_bracket_z+fudge])
        cube([camera_holder_plate_Attachment_bracket_x,
               camera_holder_plate_height,
               camera_holder_plate_Attachment_bracket_z]);
        }

        // Plate Attach screw Holes 
        translate([-(camera_holder_plate_Attachment_bracket_x-camera_holder_arm_thickness)/2,
                   camera_holder_plate_Attachment_bracket_screw_offset,
                   -camera_holder_plate_Attachment_bracket_z])
        cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,
                 h=camera_holder_plate_Attachment_bracket_z+(2*fudge));
        
        
        translate([-(camera_holder_plate_Attachment_bracket_x-camera_holder_arm_thickness)/2,
                   -camera_holder_plate_Attachment_bracket_screw_offset,
                   -camera_holder_plate_Attachment_bracket_z])
        cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,
                 h=camera_holder_plate_Attachment_bracket_z+(2*fudge));

        hull() {
        translate([-fudge,5,camera_holder_plate_offset/2-11])
        rotate([0,90,0])
        cylinder(r=8/2+fudge,h=camera_holder_arm_thickness+(4*fudge));

        translate([-fudge,-6,camera_holder_plate_offset/2-11])
        rotate([0,90,0])
        cylinder(r=8/2+fudge,h=camera_holder_arm_thickness+(4*fudge));
        } 

        translate([-(camera_holder_plate_Attachment_bracket_x-camera_holder_arm_thickness)/2,
                   camera_holder_plate_Attachment_bracket_screw_offset,
                   -2])
        rotate([0,0,30])
        cylinder(r=camera_holder_plate_Attachment_bracket_screw_nut_size,
                 h=2+(2*fudge),$fn=6);

        translate([-(camera_holder_plate_Attachment_bracket_x-camera_holder_arm_thickness)/2,
                   -camera_holder_plate_Attachment_bracket_screw_offset,
                   -2])
        rotate([0,0,30])
        cylinder(r=camera_holder_plate_Attachment_bracket_screw_nut_size,
                 h=2+(2*fudge),$fn=6);
    }
}




//##########################################################
module camera_holder_arm_w_servo_hub_cutout ()
//##########################################################
{

   difference() {
      camera_holder_no_cutout();
    /*//
        translate([30.5,-5.2,1])
         cube([10,10,5]);
   //*/
       color("red")            
        translate([0,0,camera_holder_arm_thickness])
          rotate([0,90,0])
          translate([-fudge,0,camera_holder_plate_offset])
            rotate([0,90,0])
    {
            // Center hub center hole
    translate([0,0,-servo_arm_hub_height+servo_arm_tip_height-fudge])
        cylinder(r=servo_arm_hub_center_hole_radi,h=camera_holder_arm_thickness*2);

    // Center hub drive pin hole
    //translate([0,0,-servo_arm_hub_height+servo_arm_tip_height-fudge])
        cylinder(r=servo_drive_pin_radi+0.03,h=servo_drive_pin_height+(2*fudge));

 
    }
    
   }

}

//##########################################################
module camera_holder_arm_w_servo_cutout ()
//##########################################################
{
   difference() {
       camera_holder_no_cutout();
       translate([0,0,camera_holder_arm_thickness])
       rotate([0,90,0])
          translate([-fudge,0,camera_holder_plate_offset])
            rotate([0,90,0])
            servo_arm_negative();
   }

}


//##########################################################
module camera_holder_arm_w_round_cutout()
//##########################################################
{
   difference() {
       camera_holder_no_cutout();
       translate([0,0,camera_holder_arm_thickness])
       rotate([0,90,0])
          translate([-fudge,0,camera_holder_plate_offset])
            rotate([0,90,0])
            servo_arm_negative();
   }

}

//##########################################################
module upper_pivot_bearing_holder()
//##########################################################
{
   translate([0,0,1.4+3.5+2.0])
   rotate([0,180,0])
   union() {
   difference() {
    union() {
    cylinder(r=8/2-fudge,h=1.4);
    translate([0,0,1.4])
      cylinder(r=9.5/2-fudge,h=3.6);
    translate([0,0,3.5])
      cylinder(r=14/2-fudge,h=3.5);
    }
    translate([0,0,-fudge])
    cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,h=1.4+1.6+2.0+(2*fudge));

    // Screw Head
    translate([0,0,(1.40+1.40)])
    cylinder(r=6.5/2,h=20.+(2*fudge));


   }

    translate([0,0,(1.40+1.40)])
    cylinder(r=6.5/2,h=.2);
   }
}

//##########################################################
module lower_pivot_bearing_holder()
//##########################################################
{
   difference() {
    union() {
    cylinder(r=9.5/2-fudge,h=1.4);
    cylinder(r=8/2-fudge,h=1.40+1.4);
    }
    translate([0,0,-fudge])
    cylinder(r=camera_holder_plate_Attachment_bracket_screw_radi,h=1.40+1.4+(2*fudge));
   }
}

//##########################################################
module camera_holder ()
//##########################################################
{

	// Camera Holder Arms
    hull() {
        translate([0,0,camera_holder_plate_offset])
            rotate([0,90,0])
                 cylinder(r=camera_holder_arm_servo_hub_radi,
                          h=camera_holder_arm_thickness);
        translate([0,-camera_holder_plate_height/2,0])
            cube([camera_holder_arm_thickness,camera_holder_plate_height,1]);
    }

    translate([camera_holder_plate_width-camera_holder_arm_thickness,0,0])
    hull() {
        translate([0,0,camera_holder_plate_offset])
            rotate([0,90,0])
                 cylinder(r=camera_holder_arm_servo_hub_radi,
                          h=camera_holder_arm_thickness);
        translate([0,-camera_holder_plate_height/2,0])
            cube([camera_holder_arm_thickness,camera_holder_plate_height,1]);
    }
    translate([0,-camera_holder_plate_height/2,-camera_holder_plate_thickness+fudge])
    cube([camera_holder_plate_width,camera_holder_plate_height,
          camera_holder_plate_thickness]);

}

//##########################################################
module servo_arm (angle=0)
//##########################################################
{

    rotate([0,0,angle])
    translate([0,0,(servo_arm_hub_height-servo_arm_tip_height)])
    difference() {
        union() {
            hull() {
                cylinder(r=servo_arm_hub_radi2,h=servo_arm_tip_height);
                translate([servo_arm_centerhubtooutterpin,0,0])
                    cylinder(r=servo_arm_tip_radi,h=servo_arm_tip_height);
            }
            // Center Hub
          translate([0,0,-servo_arm_hub_height+servo_arm_tip_height])
                cylinder(r=servo_arm_hub_radi,h=servo_arm_hub_height);
        }

    // Servo Arm Holes
    translate([servo_arm_centerhubtooutterpin,0,-fudge])
        cylinder(r=servo_arm_pin_hole_radi,h=servo_arm_tip_height+(2*fudge));
    translate([servo_arm_centerhubtooutterpin-(1*servo_arm_pin_spacing),0,-fudge])
        cylinder(r=servo_arm_pin_hole_radi+(1*fudge),h=servo_arm_tip_height+(2*fudge));
    translate([servo_arm_centerhubtooutterpin-(2*servo_arm_pin_spacing),0,-fudge])
        cylinder(r=servo_arm_pin_hole_radi,h=servo_arm_tip_height+(2*fudge));
    translate([servo_arm_centerhubtooutterpin-(3*servo_arm_pin_spacing),0,-fudge])
        cylinder(r=servo_arm_pin_hole_radi,h=servo_arm_tip_height+(2*fudge));

    // Center hub center hole
    translate([0,0,-servo_arm_hub_height+servo_arm_tip_height-fudge])
        cylinder(r=servo_arm_hub_center_hole_radi,h=servo_arm_hub_height+(2*fudge));

    // Center hub drive pin hole
    translate([0,0,-servo_arm_hub_height+servo_arm_tip_height-fudge])
        cylinder(r=servo_drive_pin_radi,h=servo_drive_pin_height+(2*fudge));

    // Center hub countersink for screw
    translate([0,0,servo_arm_tip_height-servo_arm_hub_center_countersink_height])
        cylinder(r=servo_arm_hub_center_countersink_radi,
                 h=servo_arm_hub_center_countersink_height+fudge);
    }
}

module servo_hub_negative(angle = 0)
{
        rotate([0,0,angle]) {
        cylinder(r=servo_arm_hub_radi+servo_arm_fudge_factor,h=servo_arm_hub_height);
    }
    // Center hub countersink for screw
    translate([0,0,servo_arm_hub_height-fudge])
        cylinder(r=servo_arm_hub_center_hole_radi,
                 h=servo_arm_hub_height+fudge);
    
}
//##########################################################
module servo_arm_negative (angle=0)
//##########################################################
{
    servo_hub_negative(angle);
    
    hull() {
        cylinder(r=servo_arm_hub_radi2+servo_arm_fudge_factor,h=servo_arm_hub_height);
        translate([servo_arm_centerhubtooutterpin,0,0])
            cylinder(r=servo_arm_tip_radi+servo_arm_fudge_factor,h=servo_arm_hub_height);
    }
    

}


//##########################################################
module MakePlate() {
//##########################################################
	difference() {	
		minkowski() {
			cube([Plate_X_Size,Plate_Y_Size,Plate_Height/2]);
			cylinder(r=Plate_Corner_Radi,h=Plate_Height/2);

		}

		// Holes
   	translate([0,0,-fudge]) 
		cylinder(r=Plate_Hole_Radi,h=Plate_Height+(2*fudge));
   	translate([Plate_X_Size,0,-fudge]) 
		cylinder(r=Plate_Hole_Radi,h=Plate_Height+(2*fudge));
   	translate([0,Plate_Y_Size,-fudge]) 
		cylinder(r=Plate_Hole_Radi,h=Plate_Height+(2*fudge));
   	translate([Plate_X_Size,Plate_Y_Size,-fudge]) 
		cylinder(r=Plate_Hole_Radi,h=Plate_Height+(2*fudge));
	}
}

module servo() {
    translate([-10.6,5.9,-27.2])
      rotate([90,0,0])   
       import("Servo9g.stl");
}

module servo_bracket() {
   difference() {
       translate([0,-2,0])
            cube([servo_plate_len, servo_plate_width+2, servo_plate_thickness]);
            
            // Holes for screws
            translate([servo_plate_screw_offset,servo_plate_width/2,0])
               cylinder(r=servo_plate_screw_radi, h=servo_plate_thickness*2+1,center=true);
            translate([servo_plate_screw_offset+servo_plate_screw_distance,servo_plate_width/2,0])
               cylinder(r=servo_plate_screw_radi, h=servo_plate_thickness*2+1,center=true); 
       
    // place for servo
    translate([(servo_plate_len-servo_plate_internal_len)/2-fudge, 0,-1])
              cube([servo_plate_internal_len+2*fudge, servo_plate_width+5, servo_plate_thickness+3]);
   }
}

module new_cam_holder() {
    translate([-10.5,-servo_plate_width/2,-9]) 
    {
        servo_bracket();

    translate([0,-2.1,-servo_hight+servo_plate_thickness+1])
       cube([servo_plate_len, 2.5, servo_hight-1]);  
        
     color("green")   
     translate([15.7,-4.2,-5.5]) 
      rotate([90,0,0])
         import("livcam_cinima_round_mount.stl");  
    }      
        
        /*
        servo_plate_len = 32;
servo_plate_width = 12;
servo_plate_thickness = 1;
servo_plate_screw_radi = 2/2;
servo_plate_screw_distance = 27.7/2;
        servo_plate_screw_offset
        servo_plate_internal_len = 22.4;

        */
}

//##########################################################
module new_exploded_view (angle=0)
//##########################################################
{

    color("Purple")
    translate([camera_holder_plate_width,camera_holder_plate_height/2,
           camera_holder_plate_Attachment_bracket_z+camera_holder_plate_thickness])
        rotate([0,-90,0])
            camera_holder_arm_w_servo_cutout();

    
        translate([camera_holder_plate_width-5.5,camera_holder_plate_height/2,camera_holder_plate_offset+camera_holder_plate_thickness+camera_holder_plate_Attachment_bracket_z])
    rotate([0,90,0])
    union() {
        color("Blue")
        servo_arm(0);
        rotate([0,0,angle])
        color("yellow")
        servo();
        
        //color("green") 
            new_cam_holder();

        
    
    }
}




