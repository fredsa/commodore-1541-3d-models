// Fix z-fighting.
delta=0.01;

// Maximize cylinder line segements.
$fs=0.01;

// Typical 5mm LED.
ledd=5;
ledz=8.5;
ledrimz=1;
leddomez=1;

// Thickness of LED holder above face plate.
ledholderfacez=1;

// Faceplate model hole inner diameter.
faceplateID=8.5;


difference() {
    // Holder.
    ledholder();

    // Led.
    translate([0, 0, -delta])
        cylinder(h=ledz-ledrimz-leddomez+2*delta, r=ledd/2);
}

module ledholder() {
    // Face.
    cylinder(h=ledholderfacez, r=faceplateID/2+1);
    
    // Body.
    cylinder(h=ledz-ledrimz-leddomez, r=faceplateID/2);

}