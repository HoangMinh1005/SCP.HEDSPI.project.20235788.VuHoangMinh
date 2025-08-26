package entity.npc;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.Random;

import entity.Entity;
import main.GamePanel;

public class NPC_OldMan extends Entity{
	public int maxMana;
	public int mana;
	GamePanel gp;
	public NPC_OldMan(GamePanel gp) {
		super(gp);
		
		this.gp = gp;
		direction = "down";
		speed = 1;
		
		solidArea.x = 1;
		solidArea.y = 2;
		solidArea.width = 40;
		solidArea.height = 40;
		solidAreaDefaultX = solidArea.x;
		solidAreaDefaultY = solidArea.y;
		Talk();
		getImage();
		
	}
	public void getImage() {
		
			up1 = setup("/NPC/oldman_up_1", gp.TileSize, gp.TileSize);
			up2 = setup("/NPC/oldman_up_2", gp.TileSize, gp.TileSize);
			down1 = setup("/NPC/oldman_down_1", gp.TileSize, gp.TileSize);
			down2 = setup("/NPC/oldman_down_2", gp.TileSize, gp.TileSize);
			left1 = setup("/NPC/oldman_left_1", gp.TileSize, gp.TileSize);
			left2 = setup("/NPC/oldman_left_2", gp.TileSize, gp.TileSize);
			right1 = setup("/NPC/oldman_right_1", gp.TileSize, gp.TileSize);
			right2 = setup("/NPC/oldman_right_2", gp.TileSize, gp.TileSize);

	}
	
	public void Talk() {
		
		dialogue[0]= "Hello";
		dialogue[1]= "Welcome to my world";
		dialogue[2]= "anh Jack J97 J97 J97 Thien Ly oi, Hong Nhan, \nBac Phan, Song Gio, Em gi oi, Duoi tan cay kho\n hoa noTram dung chan";
		dialogue[3]= "my Idolllllllll!!!!!!!!!!!!!!";
	}
	public void Move() {
		
		actionLockCounter++;
		
		if (actionLockCounter == 120){

			Random random = new Random();
			int i = random.nextInt(100) + 1; //pickup a number from 100 to 1
			
			if(i <= 25 ) {
				direction = "up";
			}
			if(i > 25 && i <= 50 ) {
				direction = "down";
			}
			if(i > 25 && i <= 75 ) {
				direction = "left";
			}
			if(i > 75 ) {
				direction = "right";
			}
			
			actionLockCounter = 0;
		}
	}
	
	public void speak() {
		if(dialogue[dialogueIndex] == null) {
			dialogueIndex = 0;
		}
		gp.ui.currentDialogue = dialogue[dialogueIndex];
		dialogueIndex++;

		switch(gp.player.direction) {
		case "up":
			direction ="down";
			break;
		case "down":
			direction ="up";
			break;
		case "left":
			direction ="right";
			break;
		case "right":
			direction ="left";
			break;
		}
	}
	public void update() {
		
		collisionOn = false;
		gp.cChecker.checkTile(this);
		gp.cChecker.checkPlayer(this);
		
		//if collision is false, player can move
		if(collisionOn == false) {
			
			switch(direction) {
			case "up":	 worldY -= speed; break;
			case "down": worldY += speed; break;
			case "left": worldX -= speed; break;
			case "right":worldX += speed; break;
			}
		}
	}
	
	public void draw(Graphics2D g2) {
		
		BufferedImage image = null;
		int screenX = worldX - gp.player.worldX + gp.player.screenX;
		int screenY = worldY - gp.player.worldY + gp.player.screenY;
		
		if(worldX + gp.TileSize > gp.player.worldX - gp.player.screenX 
			&& worldX - gp.TileSize < gp.player.worldX + gp.player.screenX
			&& worldY + gp.TileSize > gp.player.worldY - gp.player.screenY 
			&& worldY - gp.TileSize < gp.player.worldY + gp.player.screenY) {
		
			switch(direction) {
			case "up":
				if (spriteNum == 1) {
					image = up1;
				}
				if(spriteNum == 2) {
					image = up2;
				}
				break;
			case "down":
				if (spriteNum == 1) {
					image = down1;
				}
				if(spriteNum == 2) {
					image = down2;
				}
				break;
			case "left":
				if (spriteNum == 1) {
					image = left1;
				}
				if(spriteNum == 2) {
					image = left2;
				}
				break;
			case "right":
				if (spriteNum == 1) {
					image = right1;
				}
				if(spriteNum == 2) {
					image = right2;
				}
				break;
				
			}
			g2.drawImage(image, screenX, screenY, null);
			changeAlpha(g2,1f);
		}
		
	}
}























