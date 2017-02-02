// Cono.pde
// tetracono half-red, half-green cone

public class Cono {
    private int speed;
    private int sides;
    private boolean debug = true;
    private int debugalpha = 255;
    private float top, base, height;
    private color black = color(0, debugalpha);
    private color red = color(237, 28, 36, debugalpha);
    private color green = color(0, 104, 56, debugalpha);

    // constructor
    public Cono(int speed) {
    	this.speed = speed;
    }

    // base
    public void setBase(float radius) {
        this.base = radius;
    }
    public float getBase() {
        return base;
    }

    // top
    public void setTop(float radius) {
        this.top = radius;
    }
    public float getTop() {
        return top;
    }

    // height
    public void setHeight(float height) {
        this.height = height;
    }
    public float getHeight() {
        return height;
    }

    // sides
    public void setSides(int sides) {
	// number of sides of the base polygon
	// ~ 24 - 256
        this.sides = sides;
    }
    public int getSides() {
        return sides;
    }

    void draw() {
        float angle = 0;
        float angleIncrement = TWO_PI / sides;
        angleIncrement /= 2;  // draw half a cone only

        // spin
        // ** perhaps break out to udate and display() **
        if (debug)
            println(counter);
 
        pushMatrix();
        rotateY(TWO_PI*counter*speed*.0001);

        // draw half-cone
        fill(red);
        beginShape(QUAD_STRIP);
        for (int i = 0; i < sides + 1; ++i) {
            vertex(top*cos(angle), 0, top*sin(angle));
            vertex(base*cos(angle), height, base*sin(angle));
            angle += angleIncrement;
        }
        endShape();

        angle -= angleIncrement;    // *fix* correct for autoincrement above

        // draw other half-cone
        fill(green);
        beginShape(QUAD_STRIP);
        for (int i = 0; i < sides + 1; ++i) {
             vertex(top*cos(angle), 0, top*sin(angle));
             vertex(base*cos(angle), height, base*sin(angle));
             angle += angleIncrement;
        }
        endShape();

        fill(black);		
        angleIncrement *= 2;  // draw full circles now

        if (top != 0) {
            angle = 0;
            beginShape(TRIANGLE_FAN);
            vertex(0, 0, 0);
            for (int i = 0; i < sides + 1; i++) {
                vertex(top * cos(angle), 0, top * sin(angle));
                angle += angleIncrement;
            }
            endShape();
        }   

        if (base != 0) {
            angle = 0;
            beginShape(TRIANGLE_FAN);
            vertex(0, height, 0);
            for (int i = 0; i < sides + 1; i++) {
                vertex(base * cos(angle), height, base * sin(angle));
                angle += angleIncrement;
            } 
            endShape();
        }
        popMatrix();
    }
}

