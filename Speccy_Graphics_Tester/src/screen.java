import java.awt.Graphics;
import java.awt.Color;
import java.io.IOException;

public class screen {
	
	final int SCREEN_WIDTH = 256;
	final int SCREEN_HEIGHT = 192;
	final int BLOCK = 8;
	
	boolean color = false;
	DrawingPanel dp;
	Graphics g;
	
	public screen() {
		dp = new DrawingPanel(SCREEN_WIDTH,SCREEN_HEIGHT);
		g = dp.getGraphics();
		g.setColor(Color.GRAY);
		g.fillRect(0, 0, SCREEN_WIDTH -1, SCREEN_HEIGHT -1);
		return;
	}
	
	public void drawBlock(int x, int y) {
		if (color) {
			g.setColor(Color.RED);	
		} else {
			g.setColor(Color.BLACK);
		}
		color = !color;
		g.fillRect((x + 16) * 8, (y + 12) * 8, BLOCK, BLOCK);
		return; 
	}
	
	public void drawBlock(int[] x) {
		if (color) {
			g.setColor(Color.RED);	
		} else {
			g.setColor(Color.BLACK);
		};
		color = !color;
		g.fillRect((x[0] + 16) * 8, (x[1] + 12) * 8, BLOCK, BLOCK);
		return; 
	}
	
	public void eraseBlock(int x,  int y) {
		g.setColor(Color.GRAY);
		g.fillRect(x, y, BLOCK, BLOCK);
		return; 

	}
	
	public void type(String s) {
		Color oldColor = g.getColor();
		g.setColor(Color.BLACK);
		g.drawString(s, 100, 170);
		g.setColor(oldColor);
		return; 
	}
	
	public void saveDrawingPanel(String fileName) {
        try {
            dp.save(fileName);
        } catch (IOException e) {
            System.out.println("Unable to save DrawingPanel");
        }
    }
	
	public void clear() {
		g.setColor(Color.GRAY);
		g.fillRect(0, 0, SCREEN_WIDTH -1, SCREEN_HEIGHT -1);
	}

}
