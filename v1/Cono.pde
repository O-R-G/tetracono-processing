// Cono.pde
// tetracono half-red, half-green cone

public class Cono {
    private int speed;
    private int sides;
    private boolean debug;
    private int debugalpha = 255;
    private float top, base, height;
    private color black = color(0, debugalpha);
    private color red = color(237, 28, 36, debugalpha);
    private color green = color(0, 70, 36, debugalpha);
    private float rotation;
    
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
    	// number of sides of the base polygon ~ 24 - 256
        this.sides = sides;
    }
    public int getSides() {
        return sides;
    }

    // percent visible
    public float getPercentVisibleRed() {
        float percentvisible = map(cos(rotation), -1, 1, 0, 100);
        return percentvisible;
    }

    // update
    void update() {
        float millis = map(millis(), 0, speed*1000, 0, TWO_PI);
        rotation = millis*adjustspeeds;
        if (debug)
            println(nf((millis() / 1000) / 60, 2) + ":" + nf((millis() / 1000) % 60, 2));
    }

    // update non-realtime 
    void updatenonrealtime() {
        // for exportvideo @ 30 fps
        float millis = map(counter/30, 0, speed*1000, 0, TWO_PI);
        rotation = millis*adjustspeeds;
        if (debug)
            println(nf(((counter/30) / 1000) / 60, 2) + ":" + nf(((counter/30) / 1000) % 60, 2));
    }

    void display() {
        float angle = 0;
        float angleIncrement = TWO_PI / sides;
        angleIncrement /= 2;  // draw half a cone only

        // spin
        pushMatrix();
        rotateY(rotation);

        // draw half-cone
        fill(green);
        // stroke(green);
        beginShape(QUAD_STRIP);
        for (int i = 0; i < sides + 1; ++i) {
            vertex(top*cos(angle), 0, top*sin(angle));
            vertex(base*cos(angle), height, base*sin(angle));
            angle += angleIncrement;
        }
        endShape();

        angle -= angleIncrement;    // *fix* correct for autoincrement above

        // draw other half-cone
        fill(red);
        // stroke(red);
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
