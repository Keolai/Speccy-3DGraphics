import java.util.Arrays;

public class runner {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		screen s = new screen();
		
		//int[] matrix = {2,1,0,2,0,0}; //should slant
		putFirstSquare(s);
		//screen y = new screen();
		//slant(y);
		screen w = new screen();
		for (int i = 0; i <= 360; i += 30) {
			rotateNEW(w,i);
		}
	}
	
	public static void putFirstSquare(screen s) {
		s.drawBlock(2,2);
		s.drawBlock(2,0);
		s.drawBlock(4,0);
		s.drawBlock(4,2);
		return; 
	}
	
	public static void slant(screen s) {
		int[] matrix = {2,1,0,2,2,0};
//		twoDMatrix m = new twoDMatrix(matrix);
//		int[] coords = m.solveTwoDMatrix();
//		s.drawBlock(coords);
//		m.updateMatrixXY(2,4);
//		coords = m.solveTwoDMatrix();
//		s.drawBlock(coords);
//		m.updateMatrixXY(6,0);
//		coords = m.solveTwoDMatrix();
//		s.drawBlock(coords);
//		m.updateMatrixXY(6,4);
//		coords = m.solveTwoDMatrix();
//		s.drawBlock(coords);
		matrixMult m = new matrixMult(matrix);
		int[] coords = m.getCoords();
		s.drawBlock(coords);
		m.updateMatrix(2,4);
		coords = m.getCoords();
		s.drawBlock(coords);
		m.updateMatrix(6,0);
		coords = m.getCoords();
		s.drawBlock(coords);
		m.updateMatrix(6,4);
		coords = m.getCoords();
		s.drawBlock(coords);
		
	}
	
	public static void rotate(screen s) {
		int[] matrix = {1,-1,1,1,2,0};
		twoDMatrix m = new twoDMatrix(matrix);
		int[] coords = m.solveTwoDMatrix();
		coords[1] += 3;
		System.out.println(Arrays.toString(coords));
		s.drawBlock(coords);
		m.updateMatrixXY(2,0);
		coords = m.solveTwoDMatrix();
		coords[1] += 3;
		System.out.println(Arrays.toString(coords));
		s.drawBlock(coords);
		m.updateMatrixXY(4,0);
		coords = m.solveTwoDMatrix();
		coords[1] += 3;
		System.out.println(Arrays.toString(coords));
		s.drawBlock(coords);
		m.updateMatrixXY(4,2);
		coords = m.solveTwoDMatrix();
		coords[1] += 3;
		System.out.println(Arrays.toString(coords));
		s.drawBlock(coords);
	}
	
	public static void rotate2(screen s) {
		int[] matrix = {0,-1,1,0,2,0};
		matrixMult m = new matrixMult(matrix);
		int[] coords = m.getCoords();
		s.drawBlock(coords);
		m.updateMatrix(2,2);
		coords = m.getCoords();
		System.out.println(Arrays.toString(coords));
		s.drawBlock(coords);
		m.updateMatrix(4,0);
		coords = m.getCoords();
		s.drawBlock(coords);
		m.updateMatrix(4,2);
		coords = m.getCoords();
		s.drawBlock(coords);
	}
	
	public static void rotateNEW(screen s, int r) {
//		s.drawBlock(2,2);
//		s.drawBlock(2,0);
//		s.drawBlock(4,0);
//		s.drawBlock(4,2);
		int[] matrix = {2,0};
		RotateMatrix m = new RotateMatrix(matrix, r);
		int[] coords = m.getCoords();
		System.out.println(Arrays.toString(coords));
		s.drawBlock(coords);
		s.drawBlock(coords);
		m.updateMatrix(2,2);
		coords = m.getCoords();
		System.out.println(Arrays.toString(coords));
		s.drawBlock(coords);
		m.updateMatrix(4,0);
		coords = m.getCoords();
		s.drawBlock(coords);
		m.updateMatrix(4,2);
		coords = m.getCoords();
		s.drawBlock(coords);
		s.type("rotation: " + r + " degrees");
		String file = "frame_" + r + ".png";
		s.saveDrawingPanel(file);
		s.clear();
	}
	
}
