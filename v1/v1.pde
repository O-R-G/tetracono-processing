// Tetracono
// O-R-G
//
// based on Vertices by Simon Greenwold
// https://processing.org/examples/vertices.html

int counter = 0;
color red = color(237, 28, 36);
color green = color(0, 104, 56);
int[] cone = new int[4];	// would be better to use an object
// much better to instantiate a cone object 
// with all properties in it and a method to draw itself

Cono cono;


void setup() {
    size(800, 800, P3D);
    cone[0]=1;	// top radius
    cone[1]=75;	// bottom radius 
    cone[2]=75;	// height 
    // cone[3]=256;	// # sides
    cone[3]=64;	// # sides

    cono = new Cono(100);
    cono.setTop(20.0);
    cono.setBase(200.0);
    cono.setHeight(50.0);
    println("* * *");
    println(cono.getTop());
    println(cono.getBase());
    println(cono.getHeight());
}

void draw() {
  background(0);
  lights();
  translate(width / 2, height / 2);
  // scale(2);

  rotateY(map(mouseX, 0, width, 0, PI));
  rotateZ(map(mouseY, 0, height, 0, -PI));
  noStroke();

  fill(red);
  // noFill();
  // stroke(red);
  drawCylinder(cone[0], cone[1], cone[2], cone[3]); 

  rotateX(TWO_PI/2);
  fill(green);
  // noFill();
  // stroke(green);
  drawCylinder(cone[0], cone[1], cone[2], cone[3]); 

  rotateX(TWO_PI/4);
  fill(red);
  // noFill();
  // stroke(red);
  drawCylinder(cone[0], cone[1], cone[2], cone[3]); 

  rotateX(TWO_PI/2);
  fill(green);
  // noFill();
  // stroke(green);
  drawCylinder(cone[0], cone[1], cone[2], cone[3]); 

  noFill();
  stroke(255);
  box(150);
}

void drawCylinder(float topRadius, float bottomRadius, float tall, int sides) {
  float angle = 0;
  float angleIncrement = TWO_PI / sides;
  angleIncrement /= 2;	// draw half a cone only

  // draw half-cone
  fill(red);
  beginShape(QUAD_STRIP);
  for (int i = 0; i < sides + 1; ++i) {
    vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
    vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
    angle += angleIncrement;
  }
  endShape();

  // draw other half-cone
  fill(green);
  beginShape(QUAD_STRIP);
  for (int i = 0; i < sides + 1; ++i) {
    vertex(topRadius*cos(angle), 0, topRadius*sin(angle));
    vertex(bottomRadius*cos(angle), tall, bottomRadius*sin(angle));
    angle += angleIncrement;
  }
  endShape();

  fill(0);
  angleIncrement *= 2;  // draw full circles now

  // circular top cap
  if (topRadius != 0) {
    angle = 0;
    beginShape(TRIANGLE_FAN);
    
    // Center point
    vertex(0, 0, 0);
    for (int i = 0; i < sides + 1; i++) {
      vertex(topRadius * cos(angle), 0, topRadius * sin(angle));
      angle += angleIncrement;
    }
    endShape();
  }

  // circular bottom cap
  if (bottomRadius != 0) {
    angle = 0;
    beginShape(TRIANGLE_FAN);

    // Center point
    vertex(0, tall, 0);
    for (int i = 0; i < sides + 1; i++) {
      vertex(bottomRadius * cos(angle), tall, bottomRadius * sin(angle));
      angle += angleIncrement;
    }
    endShape();
  }
// quantum weirdness
if (counter % 2 == 0) {
  rotateY(TWO_PI+counter*.01);
} else {
  rotateX(TWO_PI+counter*.01);
}
  counter++;
}
