// Tetracono
// O-R-G
//
// based on Vertices by Simon Greenwold
// https://processing.org/examples/vertices.html

int conos = 4;                                      
Cono[] cono;
float[] dimensions =  {1.0, 75.0, 75.0, 24};    // top, base, height, sides 
int[] speeds = {-90, -60, 72, 108};             // uno, due, tre, quattro    
float adjustspeeds = 1.0;                       // global
int boxsize = 150;                              // box dimension x=y=z

void setup() {
    size(800, 800, P3D);

    cono = new Cono[conos];
    for (int i = 0; i < conos; i++) {
        cono[i] = new Cono(speeds[i]);
        cono[i].setTop(dimensions[0]);
        cono[i].setBase(dimensions[1]);
        cono[i].setHeight(dimensions[2]);
        cono[i].setSides(int(dimensions[3]));
    }
}

void draw() {
    background(0);
    lights();
    // pointLight(255, 255, 255, 35, 40, 255);
    // directionalLight(255, 255, 255, -1, 0, 0);
    noStroke();
    translate(width/2, height/2);
    scale(2);
  
    // global 3d controls
    rotateY(map(mouseX, 0, width, 0, PI));
    // rotateZ(map(mouseY, 0, height, 0, -PI));
    scale(map(mouseY, 0, height, 0, 6));

    // uno
    pushMatrix();
    cono[0].update();
    cono[0].display();
    popMatrix();

    // due
    pushMatrix();
    rotateX(TWO_PI/2);
    rotateY(TWO_PI/2);
    cono[1].update();
    cono[1].display();
    popMatrix();

    // tre
    pushMatrix();
    rotateZ(TWO_PI/4);
    cono[2].update();
    cono[2].display();
    popMatrix();

    // quattro
    pushMatrix();
    rotateZ(-TWO_PI/4);
    cono[3].update();
    cono[3].display();
    popMatrix();

    // box
    openbox(boxsize/2);
}

void openbox(int base) {
    fill(0);
    stroke(255,100);
    strokeWeight(.5);

    // left
    beginShape();
    vertex(-base, -base, -base);
    vertex(-base, -base,  base);
    vertex(-base,  base,  base);
    vertex(-base,  base, -base);
    endShape(CLOSE);

    // back
    beginShape();
    vertex(-base, -base, -base);
    vertex( base, -base, -base);
    vertex( base,  base, -base);
    vertex(-base,  base, -base);
    endShape(CLOSE);

    // right
    beginShape();
    vertex( base, -base, -base);
    vertex( base,  base, -base);
    vertex( base,  base,  base);
    vertex( base, -base,  base);
    endShape(CLOSE);

    // bottom
    beginShape();
    vertex(-base,  base, -base);
    vertex( base,  base, -base);
    vertex( base,  base,  base);
    vertex(-base,  base,  base);
    endShape(CLOSE);

    // top
    beginShape();
    vertex(-base, -base, -base);
    vertex( base, -base, -base);
    vertex( base, -base,  base);
    vertex(-base, -base,  base);
    endShape(CLOSE);
}

