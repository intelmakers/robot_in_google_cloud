
$fn = 60;
thickness = 2;
mount_internal_radius = 12/2;
mount_radius = 21/2;
mount_outer_radius = mount_radius;
mount_slot_width = 10+0.1;
disk_thinkness = 4.2;
fudge = 0.1;
cube_len = mount_outer_radius*2+2*thickness;


module base()
{
    

    difference() 
    {
       cube([cube_len,cube_len,disk_thinkness+2*thickness], center = true);
        
        /* for testing
       translate([0,cube_len*0.5+2,0])
       # cube([cube_len*2,cube_len*2,cube_len*2],center=true);
        */
    }

}

module slot() {
    
    // The top
    new_h = disk_thinkness + 2;
    
    translate([0,0,disk_thinkness-.1]) { 
        color("blue")
        difference() { 
           cylinder(r=mount_internal_radius, h=new_h);
           for (d = [1,-3]) {
             translate([d*(mount_slot_width/2),-mount_internal_radius,-3])
             cube([mount_slot_width,mount_slot_width,new_h+20],center=false);
           }
        }
        
       // opening
       
       c_len = (mount_slot_width);
       color("green")
       translate([0, -c_len+2, disk_thinkness/2-.1])
          cube([c_len, c_len*2, new_h], center=true); 
        
    }
    
    // The Botton
    
    cylinder(r=mount_radius+fudge, h=disk_thinkness); 
   
    c_len = (mount_radius*2+fudge);
       translate([0, -c_len/2, disk_thinkness/2])
          cube([c_len, c_len, disk_thinkness], center=true);
    
   
}

module body() {
    difference() {
        base();
        translate([0,0,-disk_thinkness/2])
         slot();
        
      //  translate([-20,0,-10])
        //   cube([40,20,20]);
     
       // for lock screw
       translate([-cube_len/2+3.7,-cube_len/2+3.9,0])
        cylinder(r=1.5,h=30, center = true);
        
       translate([cube_len/2-3.7,-cube_len/2+3.9,0])
        cylinder(r=1.5,h=30, center = true);
    }
    

}

module cover() {
    
    difference() 
    {
       cube([cube_len,thickness,disk_thinkness+2*thickness], center = true);

    } 
    translate([0,thickness-.1,0]) 
       cube([cube_len-2*thickness,thickness*1.5,disk_thinkness], center = true);
    
}
cover();
//body();
//slot();

/*
xxx = (mount_radius+0.1)*sin(45)*2;
cube([xxx,xxx,7], center=true);
echo ("xxx", xxx);
*/
