// Tetracono
// O-R-G
//
// based on Vertices by Simon Greenwold
// https://processing.org/examples/vertices.html

int counter;
int count = 4;                              // # of conos
Cono[] cono;
int[] speeds =  {-90, -60, 72, 108};          // local
float[] dimensions =  {1.0, 75.0, 75.0, 24};          // local
float speed = .1;                          // global

void setup() {
    size(800, 800, P3D);

    cono = new Cono[count];
    for (int i = 0; i < count; i++) {
        cono[i] = new Cono(speeds[i]);
        // cono[i] = new Cono(int(random(100)) + 1);   // random
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
    noFill();
    strokeWeight(.5);
    stroke(255, 100);
    box(150);

    counter++;
}
