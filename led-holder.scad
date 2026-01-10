model(
    assembled=true,
    front=true,
    back=true
    );

// Fix z-fighting.
delta=0.01;

// Maximize cylinder line segements.
$fn=100;

// Typical 5mm LED.
ledd=5;
ledrimd=ledd+1;
ledz=8;
ledrimz=1.5;
leddomez=1;
ledclearance=0.05;

frontbackclearance=0.05;

// Faceplate model hole inner diameter.
faceplateID=8.5;

// Thickness LED holder above face plate.
protrudez=1;

// OD LED holder above face plate.
protrudeod=faceplateID+1;

// Thickness of face plate wall.
faceplatewallz=2;

back_ledholder_backz=1;
back_ledholder_od=faceplateID/2+2;

module model(assembled, front, back) {
    if (assembled) {
        if (front) {
            translate([0, 0, -protrudez])
                front_ledholder();
        }
        
        if (back) {
            translate([0, 0, faceplatewallz])
                back_ledholder();
        }
    } else {
        separation=15;
        if (front) {
            translate([0, separation/2, 0])
                front_ledholder();
        }
        
        if (back) {
            translate([0, -separation/2, ledz-leddomez-protrudez+back_ledholder_backz])
            rotate([180, 0, 0])
                back_ledholder();
        }
    }
}

module front_ledholder() {
    difference() {
        solid_front_ledholder();
        led();
        %led();
    }
}

module led() {
    // Rim.
    translate([0, 0, ledz-ledrimz-leddomez])
        cylinder(h=ledrimz, r=ledrimd/2+ledclearance);

    // Main body.
    translate([0, 0, -delta])
        cylinder(h=ledz-ledrimz-leddomez+2*delta, r=ledd/2+ledclearance);

    // Dome.
    scale([1, 1, leddomez / (ledd/2+ledclearance)])
        sphere(r=ledd/2+ledclearance);
}

module solid_front_ledholder() {
    // Face.
    cylinder(h=protrudez, r=protrudeod/2);

    // Body.
    translate([0, 0, protrudez])
        cylinder(h=ledz-ledrimz-leddomez-protrudez, r=faceplateID/2-frontbackclearance);
}

module back_ledholder() {
    // Body.
    difference() {
        // OD.
        cylinder(h=ledz-leddomez-protrudez-faceplatewallz, r=back_ledholder_od);

        // ID.
        translate([0, 0, -delta])
            cylinder(h=ledz-leddomez-protrudez-faceplatewallz+2*delta, r=faceplateID/2);
    }
    
    // Back.
    translate([0, 0, ledz-leddomez-protrudez-faceplatewallz])
    difference() {
        // OD.
        cylinder(h=back_ledholder_backz, r=faceplateID/2+2);

        // ID.
        translate([0, 0, -delta])
            cylinder(h=back_ledholder_backz+2*delta, r=ledrimd/2 - ((ledrimd-ledd)/2)/2);
    }    
}