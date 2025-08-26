package entity.monster;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.util.Random;

import entity.Entity;
import entity.object.OBJ_Coin_Bronze;
import entity.object.OBJ_Heart;
import entity.object.OBJ_ManaCrystal;
import entity.object.OBJ_Rock;
import entity.object.SuperObjects;
import entity.projectile.Projectile;
import main.GamePanel;

public class MON_GreenSlime extends Entity {
	public int maxLife;
	public int life;
	public Projectile projectile;
	public int ammo;
	int hpBarCounter = 0;
	int dyingCounter = 0;
	GamePanel gp;
	public int maxMana;
	public int mana;
	public MON_GreenSlime(GamePanel gp) {
		super(gp);
	
		this.gp = gp;
		type = type_monster;
		name = "Green Slime";
		speed = 2;
		maxLife = 4;
		life = maxLife;
		attack = 5;
		defense = 0;
		exp = 2;
		projectile = new OBJ_Rock(gp);
		
		solidArea.x = 3;
		solidArea.y = 16;
		solidArea.height = 30;
		solidArea.width = 42;
		solidAreaDefaultX = solidArea.x;
		solidAreaDefaultY = solidArea.y;
		
		getImage();
	}
	public void	getImage() {
		
		up1 = setup("/monster/greenslime_down_1", gp.TileSize, gp.TileSize);
		up2 = setup("/monster/greenslime_down_2", gp.TileSize, gp.TileSize);
		down1 = setup("/monster/greenslime_down_1", gp.TileSize, gp.TileSize);
		down2 = setup("/monster/greenslime_down_2", gp.TileSize, gp.TileSize);
		left1 = setup("/monster/greenslime_down_1", gp.TileSize, gp.TileSize);
		left2 = setup("/monster/greenslime_down_2", gp.TileSize, gp.TileSize);
		right1 = setup("/monster/greenslime_down_1", gp.TileSize, gp.TileSize);
		right2 = setup("/monster/greenslime_down_2", gp.TileSize, gp.TileSize);
	}
	public void ProtectTerritory() {
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
		
		int i = new Random().nextInt(100) + 1;
		if (i > 99 &&  projectile.alive == false && shotAvailableCounter == 30) {
			projectile.set(worldX, worldY, direction, true, this);
			gp.projectileList.add(projectile);
			shotAvailableCounter = 0;
		}
	}
	
	public void damageReaction() {
	
		actionLockCounter = 0;
		direction = gp.player.direction;
	}

	public void Die() {
		
		//cast a die
		int i = new Random().nextInt(100) + 1;
		
		//set the monster drop
		if(i < 50) {
			dropItem(new OBJ_Coin_Bronze(gp));
		}
		if( i >= 50 && i < 75) {
			dropItem(new OBJ_Heart(gp));
		}
		if( i >= 75 && i < 100) {
			dropItem(new OBJ_ManaCrystal(gp));
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
		spriteCounter ++;
		if(spriteCounter > 12) {
			if(spriteNum == 1) {
				spriteNum = 2;
			}
			else if(spriteNum == 2) {
				spriteNum = 1;
			}
			spriteCounter = 0;
		}		
		if(invincible == true) {
			invincibleCounter ++;
			if(invincibleCounter > 40) {
				invincible = false;
				invincibleCounter = 0;
			}
		}
		if(shotAvailableCounter < 30) {
			shotAvailableCounter ++;
		}
	}
	
	public void damagePlayer(int attack) {
		if(gp.player.invincible == false) {
			//we can give damage
			
			int damage = attack - gp.player.defense;
			if(damage < 0 ) {
				damage = 0;
			}
			gp.player.life -= damage;
			gp.player.invincible = true;
		}
	}
	
	public void dropItem(SuperObjects droppedItem) {
		
		for ( int i = 0; i < gp.obj[1].length; i++) {
			if(gp.obj[gp.currentMap][i] == null) {
				gp.obj[gp.currentMap][i] = droppedItem;
				gp.obj[gp.currentMap][i].worldX = worldX; // the dead of monster
				gp.obj[gp.currentMap][i].worldY = worldY;
				break;
			}
		}
	}
	
	
	public void dyingAnimation(Graphics2D g2) {
		
		dyingCounter ++;	
		
		int i = 5;
		
		if(dyingCounter <= i) {	changeAlpha(g2, 0f);	}		
		if(dyingCounter > i	 && dyingCounter <= i*2)   {changeAlpha(g2, 1f);	}		
		if(dyingCounter > i *2 && dyingCounter <= i*3) {changeAlpha(g2, 0f);	}
		if(dyingCounter > i *3 && dyingCounter <= i*4) {changeAlpha(g2, 1f);	}
		if(dyingCounter > i *4 && dyingCounter <= i*5) {changeAlpha(g2, 0f);	}
		if(dyingCounter > i *5 && dyingCounter <= i*6) {changeAlpha(g2, 1f);	}
		if(dyingCounter > i *6 && dyingCounter <= i*7) {changeAlpha(g2, 0f);	}
		if(dyingCounter > i *7 && dyingCounter <= i*8) {changeAlpha(g2, 1f);	}
		if(dyingCounter > i *8) {
			alive = false;
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
			
			//Monster health bar
			if(type == 2 && hpBarOn == true) {
				
				double oneScale = (double) gp.TileSize / maxLife;
				double hpBarValue = oneScale*life;
				
				
				g2.setColor(new Color(35,35,35));
				g2.fillRect(screenX - 1, screenY - 16, gp.TileSize + 2, 2);
				
				g2.setColor(new Color(255,0,30));
				g2.fillRect(screenX, screenY - 15, (int)hpBarValue , 10);
				
				hpBarCounter++;
				
				if(hpBarCounter > 600) {
					hpBarCounter = 0;
					hpBarOn = false;
				}
			}
			
			
			if(invincible == true) {
				hpBarOn = true;
				hpBarCounter = 0;
				changeAlpha(g2,0.2F);
			}
			if(dying == true) {				
				dyingAnimation(g2);
				
			}
			
			g2.drawImage(image, screenX, screenY, null);
			changeAlpha(g2,1f);
		}
	}
}










