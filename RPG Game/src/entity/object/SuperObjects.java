package entity.object;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;

import entity.Entity;
import main.GamePanel;

public class SuperObjects extends Entity{

	public SuperObjects(GamePanel gp) {
		super(gp);
		
	}
	public void use(Entity entity) {}

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
			
			//Monster health bar
			if(type == 2 && hpBarOn == true) {
				
				double oneScale = (double) gp.TileSize / maxLife;
				double hpBarValue = oneScale*life;
				
				
				g2.setColor(new Color(35,35,35));
				g2.fillRect(screenX - 1, screenY - 16, gp.TileSize + 2, 2);
				
				g2.setColor(new Color(255,0,30));
				g2.fillRect(screenX, screenY - 15, (int)hpBarValue , 10);
				
			}
			
			g2.drawImage(image, screenX, screenY, null);
			changeAlpha(g2,1f);
		}
	}

}
