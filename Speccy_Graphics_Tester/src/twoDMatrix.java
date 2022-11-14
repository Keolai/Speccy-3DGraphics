
public class twoDMatrix {

	int a1;
	int a2;
	int a3;
	int a4;
	int x;
	int y;
	
	int[] coords;
	
	public twoDMatrix(byte a, byte b, byte c, byte d, byte e, byte f) {
		a1 = a;
		a2 = b;
		a3 = c;
		a4 = d;
		x = e;
		y = f;
		coords = new int[2];
	}
	
	public twoDMatrix(int[] m) {
		a1 = m[0];
		a2 = m[1];
		a3 = m[2];
		a4 = m[3];
		x = m[4];
		y = m[5];
		coords = new int[2];
	}
	
	public int[] solveTwoDMatrix(){
		int M = a3/a1;
		coords[1] = (y - (M * x))/(a4 - (M * a2));
		coords[0] = (x - (a2 * coords[1]))/a1;
		return coords;
	}
	
	public int[] getcoords() {
		return coords;
	}
	
	public void updateMatrixXY(int c, int d) {
		x = c;
		y = d;
		return; 
	}
}
