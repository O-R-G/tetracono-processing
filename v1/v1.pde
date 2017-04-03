// Tetracono
// O-R-G
//
// based on Vertices by Simon Greenwold
// https://processing.org/examples/vertices.html

import processing.pdf.*;

Cono[] cono;
VideoExport videoExport;
float[] dimensions;
int[] speeds;
int boxsize;
int conos;
int counter;
float adjustspeeds = 1.0;
float rotation = 0.0;
float scale = 1.0;
float fov = PI/3.0;
boolean debug = true;
boolean saveframe;
boolean exportvideo;

void setup() {
    size(800, 800, P3D);

    conos = 4;
    boxsize = height/2;

    // top, base, height, sides 
    dimensions = new float[4];
    dimensions[0] = 1.0;        
    dimensions[1] = boxsize/2;
    dimensions[2] = boxsize/2;
    dimensions[3] = 30; // [24] [30] [60] [90] [120]

    // uno, due, tre, quattro
    speeds = new int[4];
    speeds[0] = -90;
    speeds[1] = -60;
    speeds[2] =  72;
    speeds[3] = 108;

    cono = new Cono[conos];
    for (int i = 0; i < conos; i++) {
        cono[i] = new Cono(speeds[i]);
        cono[i].setTop(dimensions[0]);
        cono[i].setBase(dimensions[1]);
        cono[i].setHeight(dimensions[2]);
        cono[i].setSides(int(dimensions[3]));
    }

    // videoExport        
    videoExport = new VideoExport(this, "out/mp4/out.mov", "");
    videoExport.setFrameRate(30.0);

    // perspective
    // updatePerspective(fov);
}

void draw() {
    if (saveframe)
        beginRaw(PDF, "output-####.pdf");

    background(0);
    // lights();    // default settings
    ambientLight(128, 128, 128);
    directionalLight(128, 128, 128, 0, 0, -1);
    lightFalloff(1, 0, 0);
    lightSpecular(128, 128, 128);
    shininess(2.0);

    noStroke();
    translate(width/2, height/2);
    rotateY(rotation);
    // rotateX(rotation);
    scale(scale);
    // updatePerspective(fov);

    // update conos    
    for (int i = 0; i < cono.length; i++) {
        if (exportvideo)
            cono[i].updatenonrealtime();
        else 
            cono[i].update();
    }

    // uno
    pushMatrix();
    cono[0].display();
    popMatrix();

    // due
    pushMatrix();
    rotateX(TWO_PI/2);
    rotateY(TWO_PI/2);
    cono[1].display();
    popMatrix();

    // tre
    pushMatrix();
    rotateZ(TWO_PI/4);
    cono[2].display();
    popMatrix();

    // quattro
    pushMatrix();
    rotateZ(-TWO_PI/4);
    cono[3].display();
    popMatrix();

    // box
    openbox(boxsize/2);
    
    /*   
    // % red visible
    if (debug) {
        float totalpercentvisiblered = (cono[0].getPercentVisibleRed() + 
                                        cono[1].getPercentVisibleRed() + 
                                        cono[2].getPercentVisibleRed() + 
                                        cono[3].getPercentVisibleRed()) / 4;
        println("0 : % " + cono[0].getPercentVisibleRed());
        println("1 : % " + cono[1].getPercentVisibleRed());
        println("2 : % " + cono[2].getPercentVisibleRed());
        println("3 : % " + cono[3].getPercentVisibleRed());
        println("Σ : % " + totalpercentvisiblered);
    }
    */
    
    if (saveframe) {
        endRaw();
        saveframe = false;
    }

    if (exportvideo) {
        videoExport.saveFrame();
        counter+=1000;  // https://processing.org/reference/float.html
        if (((counter/30)/1000) / 60 >= 18/adjustspeeds)
            exit();
    }

    if (debug) {
        println(nf(((counter/30) / 1000) / 60, 2) + ":" + nf(((counter/30) / 1000) % 60, 2));
        println(nf((millis() / 1000) / 60, 2) + ":" + nf((millis() / 1000) % 60, 2));
    }
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

void updatePerspective(float fov) {
    float cameraZ = (height/2.0) / tan(PI*60.0/360.0);
    perspective(fov, float(width)/float(height), cameraZ/10.0, cameraZ*10.0);
}

void mouseDragged() {
    // global 3d controls
    float adjustX = mouseX - width/2;
    float adjustY = abs(mouseY - height/2);
    rotation = map(adjustX, 0, width/2, 0, PI);
    scale = map(adjustY, 0, height/2, 0, height/100);   
    fov = map(adjustX, 0, width/2, PI/3.0, PI/1.0);   
}

void keyPressed() {
    switch(key) {
        case '=':
        case '+':
            adjustspeeds++;
            break;
        case '-':
        case '_':
            if (adjustspeeds > 1.0)
                adjustspeeds--;
            break;
        case ' ':    
            saveframe = true;
            if (debug)
                println("fov = " + fov + " / scale = " + scale);
            break;
        case 'x':
            exportvideo = true;
            break;
        default:
            break;
    }
}
