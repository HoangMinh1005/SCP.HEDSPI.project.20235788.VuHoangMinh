package main;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.image.BufferedImage;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import javax.swing.JPanel;

import Tile.TileManager;
import entity.Entity;
import entity.player.Player;
import entity.projectile.Projectile;
import entity.monster.*;
import entity.npc.NPC_OldMan;
import entity.object.SuperObjects;

public class GamePanel extends JPanel implements Runnable{
	
	//screen settings
	final int originalTileSize = 16; //16x16 Tile
	final int scale = 3;
	
	public final int TileSize = originalTileSize * scale; // 48x48 Tile
	public final int maxScreenCol = 20;
	public final int maxScreenRow = 12;
	public final int ScreenWidth = TileSize * maxScreenCol; // 960 pixels
	public final int ScreenHeight = TileSize * maxScreenRow; // 576 pixels
	
	//World Settings
	public final int maxWorldCol = 112;
	public final int maxWorldRow = 112;
	public final int maxMap = 10;
	public int currentMap = 0;
	//for full screen
	int screenWidth2 = ScreenWidth;
	int screenHeight2 = ScreenHeight;
	BufferedImage tempScreen;
	Graphics2D g2;
	public boolean fullScreenOn = false;
	
	//FPS
	int FPS = 60;
	
	TileManager tileM = new TileManager(this);
	public KeyHandler keyH = new KeyHandler(this);
	Sound music = new Sound();
	Sound se = new Sound();
	
	public CollisionChecker cChecker = new CollisionChecker(this);
	public AssetSetter aSetter = new AssetSetter(this);
	public UI ui = new UI(this);
	public EventHandler eHandler = new EventHandler(this);
	config config = new config(this);
	Thread gameThread;
	
	//ENTITY AND OBJECT
	public Player player = new Player(this,keyH);
	public SuperObjects obj[][] = new SuperObjects[maxMap][30];
	public NPC_OldMan NPC[][] = new NPC_OldMan[maxMap][10];
	public MON_GreenSlime monster[][] = new MON_GreenSlime[maxMap][20];
	ArrayList<Entity> entityList = new ArrayList<>();
	public ArrayList<Projectile> projectileList = new ArrayList<>();
	
	//Game State
	public int gameState;
	public final int titleState = 0;
	public final int playState =  1;
	public final int pauseState = 2;
	public final int dialogueState = 3;
	public final int characterState = 4;
	public final int optionsState = 5;
	public final int gameOverState = 6;
	
	public GamePanel() {
		
		this.setPreferredSize(new Dimension(ScreenWidth, ScreenHeight));
		this.setBackground(Color.black);
		this.setDoubleBuffered(true);
		this.addKeyListener(keyH);
		this.setFocusable(true);
		
	}
	
	public void setupGame() {
		
		aSetter.setObject();
		aSetter.setNPC();
		aSetter.setMonster();
		playMusic(0);
//		stopMusic();
		gameState = titleState;
		
		tempScreen = new BufferedImage(ScreenWidth, ScreenHeight, BufferedImage.TYPE_INT_ARGB);
		g2 = (Graphics2D)tempScreen.getGraphics();
		
		if(fullScreenOn == true) {
			setFullScreen(); 
		}

	}
	public void retry() {
		
		player.setDefaultPositions();
		player.RestoreLifeAndMana();
		aSetter.setNPC();
		aSetter.setMonster();
	}
	
	public void restart() {
		player.setDefaultValue();
		player.setDefaultPositions();
		player.RestoreLifeAndMana();
		player.setItems();
		aSetter.setObject();
		aSetter.setNPC();
		aSetter.setMonster();
	}
	
	public void setFullScreen() {
		
		//get local screen device
		GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
		GraphicsDevice gd = ge.getDefaultScreenDevice();
		gd.setFullScreenWindow(Main.window);
		
		//get full screen width and height
		screenWidth2 = Main.window.getWidth();
		screenHeight2 = Main.window.getHeight();
		
	}
	public void startGameThread() {
		
		gameThread = new Thread(this);
		gameThread.start();
	}
	public void run() {
		
		double drawInterval = 1000000000/FPS;
		double delta = 0;
		long lastTime = System.nanoTime();
		long currentTime;
		long timer = 0;
		int drawCount = 0;
		
		while(gameThread != null) {
			currentTime = System.nanoTime();
			
			delta += (currentTime - lastTime) / drawInterval;
			timer += (currentTime - lastTime);
			lastTime = currentTime;
			
			if(delta >= 1) {
				update();
				drawToTempScreen();  //draw everything to the buffered image
				drawToScreen(); // draw the buffered image to the scrren
				delta--;
				drawCount++;
			}
			if(timer >= 1000000000) {
//				System.out.println("FPS :" + drawCount);
				drawCount = 0;
				timer = 0;
			}
			
		}
		
	}
	public void update() {
		
		if(gameState == playState) {
			
			player.update();
			
			//NPC
			for(int i = 0; i < NPC[1].length; i++) {
				if(NPC[currentMap][i] != null) {
					NPC[currentMap][i].update();
					NPC[currentMap][i].Move();
				}
			}
			
		 for(int i = 0; i < monster[1].length; i++) {
			 if(monster[currentMap][i] != null) {
				 if(monster[currentMap][i].alive == true && monster[currentMap][i].dying == false) {
					 monster[currentMap][i].update();
					 monster[currentMap][i].ProtectTerritory();					 
				 }
				 if(monster[currentMap][i].alive == false) {
					 monster[currentMap][i].Die();
					 monster[currentMap][i] = null;
				 }
			 }
			
		 }
			
		 for(int i = 0; i < projectileList.size() ; i++) {
			 if(projectileList.get(i) != null) {
				 if(projectileList.get(i).alive == true) {
					 projectileList.get(i).update();
				 }
				 if(projectileList.get(i).alive == false) {
					 projectileList.remove(i);
				 }
			 }
			
		 }
		}
		
		if(gameState == pauseState) {
			//nothing
		}
		

	}
	
	
	
	
	public void drawToTempScreen() {
		//Title screen
				if(gameState == titleState) {
					ui.draw(g2);
				}
				//OTHER
				else {
					//Tile
					tileM.draw(g2);
					
					//add entity to list
					entityList.add(player);
					
					for(int i = 0; i < NPC[1].length; i++) {
						if(NPC[currentMap][i] != null) {
							entityList.add(NPC[currentMap][i]);
						}
					}
				
					for (int i = 0; i < obj[1].length; i++) {
						if(obj[currentMap][i] != null) {
							entityList.add(obj[currentMap][i]);
						}
					}
					for (int i = 0; i < monster[1].length; i++) {
						if(monster[currentMap][i] != null) {
							entityList.add(monster[currentMap][i]);
						}
					}
					
					for (int i = 0; i < projectileList.size() ; i++) {
						if(projectileList.get(i) != null) {
							entityList.add(projectileList.get(i));
						}
					}
					//Sort
					Collections.sort(entityList, new Comparator<Entity>() {

						public int compare(Entity e1, Entity e2) {
							
							int result = Integer.compare(e1.worldX, e2.worldY);
							return result;
						}		
					});
				
					//draw entities
					for(int i = 0; i < entityList.size(); i++) {
						entityList.get(i).draw(g2);
					}
					// Empty Entity
					entityList.clear();
					
					//UI
					ui.draw(g2);
					}
				
				if(keyH.showDebugText == true) {
					g2.setFont(new Font("Arial", Font.PLAIN, 20));
					g2.setColor(Color.white);
					int x = 10;
					int y = 400;
					int lineHeight = 20;
					
					g2.drawString("WorldX" + player.worldX, x, y); y+=lineHeight;
					g2.drawString("WorldY" + player.worldY, x, y);y+=lineHeight;
					g2.drawString("Col" + (player.worldX + player.solidArea.x) / TileSize, x, y);y+=lineHeight;
					g2.drawString("Row" + (player.worldY + player.solidArea.y) / TileSize, x, y);
				}
	}
	public void drawToScreen() {
		
		Graphics g = getGraphics();
		g.drawImage(tempScreen, 0, 0, screenWidth2, screenHeight2, null);
		g.dispose();
	}
	public void playMusic(int i) {
		music.setFire(i);
		music.play();
		music.loop();
	}
	public void stopMusic() {
		music.stop();
	}
	public void playSE(int i) {
		se.setFire(i);
		se.play();
	}
}








