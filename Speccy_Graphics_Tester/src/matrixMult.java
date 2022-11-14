
public class matrixMult {
	
//	a1 | a2  x
//	a3 | a4  y
	
	int a1;
	int a2;
	int a3;
	int a4;
	int x;
	int y;
	
	int[] coords;
	
	public matrixMult(byte a, byte b, byte c, byte d, byte e, byte f) {
		a1 = a;
		a2 = b;
		a3 = c;
		a4 = d;
		x = e;
		y = f;
		coords = new int[2];
		solve();
	}
	
	public matrixMult(int[] m) {
		a1 = m[0];
		a2 = m[1];
		a3 = m[2];
		a4 = m[3];
		x = m[4];
		y = m[5];
		coords = new int[2];
		solve();
	}
	
	private int[] solve() {
		coords[0] = (a1 * x) + (a2 * y);
		coords[1] = (a3 * x) + (a4 * y);
		
		return coords;
	}
	
	public void updateMatrix(int c, int d) {
		x = c;
		y = d;
		solve();
		return; 
	}
	
	public int[] getCoords() {
		return coords;
	}
}
