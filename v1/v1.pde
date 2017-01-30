// Tetracono
// O-R-G
//
// based on Vertices by Simon Greenwold
// https://processing.org/examples/vertices.html

int counter = 0;
Cono cono;

void setup() {
    size(800, 800, P3D);

    cono = new Cono(50);
    cono.setTop(1.0);
    cono.setBase(75.0);
    cono.setHeight(75.0);
    cono.setSides(24);

    println("* * *");
    println(cono.getTop());
    println(cono.getBase());
    println(cono.getHeight());
    println(cono.getSides());
}

void draw() {
  background(0);
  lights();
  translate(width / 2, height / 2);
  // stroke(255, 100);
  noStroke();

  rotateY(map(mouseX, 0, width, 0, PI));
  // rotateY(map(mouseX, 0, width, 0, PI));
  // rotateZ(map(mouseY, 0, height, 0, -PI));
  scale(map(mouseY, 0, height, 0, 6));
  rotateY(-TWO_PI/4);

  cono.draw();
  rotateX(TWO_PI/2);
  cono.draw();
  rotateX(TWO_PI/4);
  cono.draw();
  rotateX(TWO_PI/2);
  cono.draw();

  noFill();
  stroke(255);
  box(150);

  counter++;
}




/*
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
*/
