
public class RotateMatrix {
//	int a1;
//	int a2;
//	int a3;
//	int a4;
	int x;
	int y;
	
	int r; //rotation 
	
	int[] coords;
	
	public RotateMatrix(byte a, byte b, byte c, byte d, byte e, byte f, int r) {
//		a1 = a * 8;
//		a2 = b * 8;
//		a3 = c * 8;
//		a4 = d * 8;
		x = e * 8;
		y = f * 8;
		coords = new int[2];
		solve();
	}
	
	public RotateMatrix(int[] m, int r) {
//		a1 = m[0] * 8;
//		a2 = m[1] * 8;
//		a3 = m[2] * 8;
//		a4 = m[3] * 8;
		x = m[0];
		y = m[1];
		coords = new int[2];
		this.r = r; 
		solve();
	}
	
	private int[] solve() {
		coords[0] = (int) ((Math.cos(Math.toRadians((double) r)) * x) - 
				( Math.sin(Math.toRadians((double) r)) * y));
		coords[1] = (int) (Math.sin(Math.toRadians((double) r) * x) +
				((Math.cos(Math.toRadians((double) r))) * y));
		
		return coords;
	}
	
	private int sinGet() {
		
		return (5 * r)/180;
	}
	
	private int cosGet() {
		
		return (- (Math.abs( 5 * r)) + 1)/180; 
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
