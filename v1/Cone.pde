// Cono.pde
// tetracono half-red, half-green cone

public class Cono {
    private color green = color(0, 104, 56);
    private color red = color(237, 28, 36);
    private int stub;
    private float top, base, height;

    public Cono(int newstub) {
	// set something
	this.stub = newstub;
    }

    // top
    public void setTop(float radius) {
        this.top = radius;
    }
    public float getTop() {
        return top;
    }

    // base
    public void setBase(float radius) {
        this.base = radius;
    }
    public float getBase() {
        return base;
    }

    // height
    public void setHeight(float height) {
        this.height = height;
    }
    public float getHeight() {
        return height;
    }


/*

   // bottom radius
   // height
   // resolution (# sides for base polygon)
   // position?

    // draw
    public void draw() {
	// draw here
    }
*/
}

