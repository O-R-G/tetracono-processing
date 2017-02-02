// Tetracono
// O-R-G
//
// based on Vertices by Simon Greenwold
// https://processing.org/examples/vertices.html

int counter;
int count = 4;                              // # of conos
Cono[] cono;
// int[] speeds =  {72, 72, 72, 72};        // local
int[] speeds =  {-90, -60, 72, 108};          // local
float speed = .01;                          // global

void setup() {
    size(800, 800, P3D);

    cono = new Cono[count];
    for (int i = 0; i < count; i++) {
        cono[i] = new Cono(speeds[i]);
        // cono[i] = new Cono(int(random(100)) + 1);   // random
        cono[i].setTop(1.0);
        cono[i].setBase(75.0);
        cono[i].setHeight(75.0);
        cono[i].setSides(24);
    }
}

void draw() {
    background(0);
    lights();
    noStroke();
    translate(width/2, height/2);
    scale(2);
  
    // global 3d controls
    rotateY(map(mouseX, 0, width, 0, PI));
    // rotateZ(map(mouseY, 0, height, 0, -PI));
    scale(map(mouseY, 0, height, 0, 6));

    // uno
    pushMatrix();
    cono[0].draw();
    popMatrix();

    // due
    pushMatrix();
    rotateX(TWO_PI/2);
    cono[1].draw();
    popMatrix();

    // tre
    pushMatrix();
    rotateZ(TWO_PI/4);
    cono[2].draw();
    popMatrix();

    // quattro
    pushMatrix();
    rotateZ(-TWO_PI/4);
    cono[3].draw();
    popMatrix();

    // box
    noFill();
    strokeWeight(.5);
    stroke(255, 100);
    box(150);

    counter++;
}
