package Actions;

import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

import Game.Dir;
import Game.Snake;

public class Key implements KeyListener {

	@Override
	public void keyPressed(KeyEvent e) {
		switch (e.getKeyCode()) {
		case KeyEvent.VK_W:
			if(!(Snake.head.getDir() == Dir.DOWN) && !Snake.waitToMove) {
				Snake.head.setDir(Dir.UP);
				Snake.waitToMove = true;
			}
			break;
			
		case KeyEvent.VK_A:
			if(!(Snake.head.getDir() == Dir.RIGHT) && !Snake.waitToMove) {
				Snake.head.setDir(Dir.LEFT);
				Snake.waitToMove = true;
			}
			
		case KeyEvent.VK_S:
			if(!(Snake.head.getDir() == Dir.UP) && !Snake.waitToMove) {
				Snake.head.setDir(Dir.DOWN);
				Snake.waitToMove = true;
			}
			
		case KeyEvent.VK_D:
			if(!(Snake.head.getDir() == Dir.LEFT) && !Snake.waitToMove) {
				Snake.head.setDir(Dir.RIGHT);
				Snake.waitToMove = true;
			}
			
		}
		
	}

	@Override
	public void keyTyped(KeyEvent e) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void keyReleased(KeyEvent e) {
		// TODO Auto-generated method stub
		
	}
	

	
	
	

}
