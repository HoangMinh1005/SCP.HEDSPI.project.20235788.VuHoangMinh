package entity.player;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;

import javax.imageio.ImageIO;

import entity.Entity;
import entity.object.OBJ_Fireball;
import entity.object.OBJ_Shield_Wood;
import entity.object.OBJ_Sword_Normal;
import entity.object.SuperObjects;
import entity.projectile.Projectile;
import main.GamePanel;
import main.KeyHandler;
import main.UtilityTool;

public class Player extends Entity{
	public Projectile projectile;
	public int strength;
	public int dexterity;
	public int level;
	public int nextLevelExp;
	public int coin;
	public SuperObjects currentWeapon;
	public SuperObjects currentShield;
	KeyHandler keyH;
	
	public final int screenX;
	public final int screenY;
	int standC = 0;
	boolean moving = false;	
	int pixelCounter = 0;
	public boolean attackCanceled = false;
	public ArrayList<SuperObjects> inventory = new ArrayList<>();
	public final int maxInventorySize = 20;
	
	public Player(GamePanel gp, KeyHandler keyH) {
		
		super(gp);
		
		
		this.keyH = keyH;
		
		screenX = gp.ScreenWidth/2 - (gp.TileSize/2);
		screenY = gp.ScreenHeight/2 - (gp.TileSize/2);
		
		solidArea = new Rectangle();
		solidArea.x = 1;
		solidArea.y = 1;
		solidAreaDefaultX = solidArea.x;
		solidAreaDefaultY = solidArea.y;
		solidArea.width = 38;
		solidArea.height = 39;
		
//		attackArea.width = 36;
//		attackArea.height = 36;
		
		setDefaultValue();
		getPlayerImage();
		getPlayerAttackImage();	
		setItems();
	}
	public void setDefaultValue() {
		
		
		worldX = gp.TileSize * 12;
		worldY = gp.TileSize * 11;
		speed = 4;
		direction = "down";
		
		//Player status
		level = 1;
		strength = 1; // more strength more dam
		dexterity = 1; // more dex less dam receive
		exp = 0;
		nextLevelExp = 5;
		coin = 0;
		maxMana = 4;
		mana = maxMana;
		currentWeapon = new OBJ_Sword_Normal(gp);
		currentShield = new OBJ_Shield_Wood(gp);
		projectile = new OBJ_Fireball(gp);
		maxLife = 6;
		life = maxLife;
		attack = getAttack(); // strength + Weapon
		defense = getDefense(); // dex + Shield
	}
	
	public void setDefaultPositions() {
		gp.currentMap = 0;
		worldX = gp.TileSize * 12;
		worldY = gp.TileSize * 11;
		direction = "down";
	}
	public void RestoreLifeAndMana() {
		life = maxLife;
		mana = maxMana;
		invincible = false;
	}
	public void setItems() {
		
		inventory.clear();
		inventory.add(currentWeapon);
		inventory.add(currentShield);
	}
	public int getAttack() {
		
		attackArea = currentWeapon.attackArea;
		return attack = strength * currentWeapon.attackValue;
	}
	public int getDefense() {
		
		return defense = dexterity * currentShield.defenseValue;
	}
	public void getPlayerImage() {
	
			up1 = setup("/player/up1", gp.TileSize, gp.TileSize);
			up2 = setup("/player/up2", gp.TileSize, gp.TileSize);
			down1 = setup("/player/down1", gp.TileSize, gp.TileSize);
			down2 = setup("/player/down2", gp.TileSize, gp.TileSize);
			left1 = setup("/player/left1", gp.TileSize, gp.TileSize);
			left2 = setup("/player/left2", gp.TileSize, gp.TileSize);
			right1 = setup("/player/right1", gp.TileSize, gp.TileSize);
			right2 = setup("/player/right2", gp.TileSize, gp.TileSize);
		
	}
	
	public void getPlayerAttackImage() {
		
		
		if(currentWeapon.type == type_sword) {
			attackUp1 = setup("/player/aup1", gp.TileSize + 23, gp.TileSize + 23);
			attackUp2 = setup("/player/aup2", gp.TileSize + 23, gp.TileSize + 23);
			attackDown1 = setup("/player/adown1", gp.TileSize + 25, gp.TileSize + 25);
			attackDown2 = setup("/player/adown2", gp.TileSize + 25, gp.TileSize + 25);
			attackLeft1 = setup("/player/aleft1", gp.TileSize + 15, gp.TileSize + 20);
			attackLeft2 = setup("/player/aleft2", gp.TileSize + 15, gp.TileSize + 20);
			attackRight1 = setup("/player/aright1", gp.TileSize + 15, gp.TileSize + 20);
			attackRight2 = setup("/player/aright2", gp.TileSize + 15, gp.TileSize + 20);
		}
		if(currentWeapon.type == type_axe) {
			attackUp1 = setup("/player/axup1", gp.TileSize + 23, gp.TileSize + 23);
			attackUp2 = setup("/player/axup2", gp.TileSize + 23, gp.TileSize + 23);
			attackDown1 = setup("/player/axdown1", gp.TileSize + 25, gp.TileSize + 25);
			attackDown2 = setup("/player/axdown2", gp.TileSize + 25, gp.TileSize + 25);
			attackLeft1 = setup("/player/axleft1", gp.TileSize + 15, gp.TileSize + 20);
			attackLeft2 = setup("/player/axleft2", gp.TileSize + 15, gp.TileSize + 20);
			attackRight1 = setup("/player/axright1", gp.TileSize + 15, gp.TileSize + 20);
			attackRight2 = setup("/player/axright2", gp.TileSize + 15, gp.TileSize + 20);
		}
	}
	
	public void update() {
		
			if(attacking == true) {
				attacking();
			}
		
		
			if(keyH.upPressed == true || keyH.downPressed == true || 
					keyH.leftPressed == true || keyH.rightPressed == true || keyH.enterPressed == true) {
				if(keyH.upPressed == true) {
					direction = "up";					
				}
				else if(keyH.downPressed == true) {
					direction = "down";
				}
				else if(keyH.leftPressed == true) {
					direction = "left";
				}
				else if(keyH.rightPressed == true) {
					direction ="right";
				}
			
				moving = true;
				
				//check tile collision
				collisionOn = false;
				gp.cChecker.checkTile(this);
				
				//CheckObject Collision
				int objIndex = gp.cChecker.checkObject(this, true);
				pickUpObject(objIndex);
				
				//Check NPC Collision
				int npcIndex = gp.cChecker.checkEntity(this, gp.NPC);
				interactNPCIndex(npcIndex);
				
				//check monster collision
				int monsterIndex = gp.cChecker.checkEntity(this, gp.monster);
				contactMonster(monsterIndex);
				
				//check event
				gp.eHandler.checkEvent();
				
		
			//if collision is false, player can move
			if(collisionOn == false && keyH.enterPressed == false) {
				
				switch(direction) {
				case "up":	 worldY -= speed; break;
				case "down": worldY += speed; break;
				case "left": worldX -= speed; break;
				case "right":worldX += speed; break;
				}
			}
			if(keyH.enterPressed == true && attackCanceled == false) {
				attacking = true;
				spriteCounter = 0;
			}
			
			attackCanceled = false;
			gp.keyH.enterPressed = false;
			
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
	}
			else {
				standC++;
				
					if(standC == 20)
					{
				spriteNum = 1;
				standC = 0;
			}
			}
			
			if(gp.keyH.shotKeyPressed == true && projectile.alive == false && shotAvailableCounter == 30
					&& projectile.haveResource(this) == true) {
				
				//set default coordinates, direction and user
				projectile.set(worldX, worldY, direction, true, this);
				
				
				//subtract the cost mana, ammo
				projectile.subtractResource(this);
				
				shotAvailableCounter = 0;
				
				gp.projectileList.add(projectile);
			}
			
			//This needs to be outside of key if statement!
			if(invincible == true) {
				invincibleCounter ++;
				if(invincibleCounter > 60) {
					invincible = false;
					invincibleCounter = 0;
				}
			}
			if(shotAvailableCounter < 30) {
				shotAvailableCounter ++;
			}
			
			if(life >= maxLife) {
				life = maxLife;
			}
			if(mana >= maxMana) {
				mana = maxMana;		
			}		
			if(life <= 0) {
				gp.gameState = gp.gameOverState;
				gp.ui.commandNum -=1;
			}		
		}
		
	public void attacking() {
		
		spriteCounter++;
		
		if(spriteCounter <= 3) {
			spriteNum = 1;
		}
		if(spriteCounter > 3 && spriteCounter <= 12) {
			spriteNum = 2;
			
			//save the current WorldX, WorldY, solid Area
			int currentWorldX = worldX;
			int currentWorldY = worldY;
			int solidAreaWidth = solidArea.width;
			int solidAreaHeight = solidArea.height;
			
			//adjust player's WorldX/Y for the attackArea
			switch(direction) {
			case"up": worldY -=attackArea.height; break;
			case"down": worldY +=attackArea.height; break;
			case"left": worldX -=attackArea.width; break;
			case"right": worldX +=attackArea.width; break;
			}
			
			//attack Area becomes solidarea
			solidArea.width = attackArea.width;
			solidArea.height = attackArea.height;
			
			//check monster collision with the update worldx,y and solidarea
			int monsterIndex = gp.cChecker.checkEntity(this, gp.monster);
			damageMonster(monsterIndex, attack);
			
			//after checking collision, restore original data
			worldX = currentWorldX;
			worldY = currentWorldY;	
			solidArea.width = solidAreaWidth;
			solidArea.height = solidAreaHeight;
			
			
		}
		if(spriteCounter > 12) {
			spriteNum = 1;
			spriteCounter = 0;
			attacking = false;
		}
	}
			
	public void pickUpObject(int i) {
		
		if(i != 999) {
			
			//pick up only items
			if(gp.obj[gp.currentMap][i].type == type_pickupOnly) {
				
				gp.obj[gp.currentMap][i].use(this);
				gp.obj[gp.currentMap][i] = null;
			}	
			//inventory items
			
			else {
				String text;
				
				if(inventory.size() != maxInventorySize) {
					
					inventory.add(gp.obj[gp.currentMap][i]);
					text = "You got a " + gp.obj[gp.currentMap][i].name + "!";
					
				}
				else {
					text = "You can not carry any more!";
				}
				
				gp.ui.addMessage(text);
				gp.obj[gp.currentMap][i]= null;	
			}
		}
	}
	
	public void interactNPCIndex(int i) {
		
		if(gp.keyH.enterPressed == true) {
			if(i != 999) {		
				attackCanceled = true;
				gp.gameState = gp.dialogueState;
				gp.NPC[gp.currentMap][i].speak();
			}
			
	}
}
	public void contactMonster(int i) {
		
		if(i != 999) {
			if(invincible == false && gp.monster[gp.currentMap][i].dying == false) {
				
				int damage = gp.monster[gp.currentMap][i].attack - defense;
				if(damage < 0 ) {
					damage = 0;
				}
				life -= damage;
				invincible = true;
			}

		}
	}
	
	public void damageMonster(int i, int attack) {
		
		if(i!=999) {
			
			if(gp.monster[gp.currentMap][i].invincible == false ) {
				
				
				int damage = attack - gp.monster[gp.currentMap][i].defense;
				if(damage < 0 ) {
					damage = 0;
				}
				
				gp.monster[gp.currentMap][i].life -= damage;
				gp.ui.addMessage(damage + " damage!");
				
				
				gp.monster[gp.currentMap][i].invincible = true;
				gp.monster[gp.currentMap][i].damageReaction();
				
				if(gp.monster[gp.currentMap][i].life <= 0) {
					gp.monster[gp.currentMap][i].dying = true;
					gp.ui.addMessage("Kill the " + gp.monster[gp.currentMap][i].name + "!");
					gp.ui.addMessage("Exp " + gp.monster[gp.currentMap][i].exp);
					exp += gp.monster[gp.currentMap][i].exp;
					checkLevelUp();
				}
			}
		}
	}
	public void checkLevelUp() {
		if(exp >= nextLevelExp) {
			
			level ++;
			nextLevelExp = nextLevelExp*2;
			maxLife +=2;
			life = maxLife;
			strength++;
			dexterity++;
			attack = getAttack();
			defense = getDefense();
			
			gp.gameState = gp.dialogueState;
			gp.ui.currentDialogue = "You are level " + level + " now!\n" + "You will get  stronger!";
		}
	}
	public void selectItem() {
		
		int itemIndex = gp.ui.getItemIndexOnSlot();
		
		if(itemIndex < inventory.size()) {
			
			SuperObjects selectedItem = inventory.get(itemIndex);
			
			if(selectedItem.type == type_sword || selectedItem.type == type_axe) {
				
				currentWeapon = selectedItem;
				attack = getAttack();
				getPlayerAttackImage();
			}
			if(selectedItem.type == type_shield) {
				currentShield = selectedItem;
				defense = getDefense();
			}
			if(selectedItem.type == type_consumable) {
				selectedItem.use(this);
				inventory.remove(itemIndex);
			}
		}
	}
 	public void draw(Graphics2D g2) {
		
		BufferedImage image = null;
		int tempScreenX = screenX;
		int tempScreenY = screenY;
		
		
		
		switch(direction) {
		case "up":
			if(attacking == false) {
				if (spriteNum == 1) {	image = up1;	}
				if(spriteNum == 2) {	image = up2;	}
			}

			if(attacking == true) {
//				tempScreenX = screenX - gp.TileSize;
				if (spriteNum == 1) {	image = attackUp1;	}
				if(spriteNum == 2) {	image = attackUp2;	}
			}
			break;
		case "down":	
			if(attacking == false) {
				if (spriteNum == 1) {	image = down1;	}
				if(spriteNum == 2) {	image = down2;	}
			}

			if(attacking == true) {
				if (spriteNum == 1) {	image = attackDown1;	}
				if(spriteNum == 2) {	image = attackDown2;	}
			}break;
		case "left":
			if(attacking == false) {
				if (spriteNum == 1) {	image = left1;	}
				if(spriteNum == 2) {	image = left2;	}
			}

			if(attacking == true) {
//				tempScreenY = screenY - gp.TileSize;
				if (spriteNum == 1) {	image = attackLeft1;	}
				if(spriteNum == 2) {	image = attackLeft2;	}
			}break;
		case "right":
			if(attacking == false) {
				if (spriteNum == 1) {	image = right1;	}
				if(spriteNum == 2) {	image = right2;	}
			}

			if(attacking == true) {
				if (spriteNum == 1) {	image = attackRight1;	}
				if(spriteNum == 2) {	image = attackRight2;	}
			}	break;	}
		
		if(invincible == true) {
			g2.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 0.4f));
		}
		
		g2.drawImage(image, tempScreenX, tempScreenY, null);

		//reset alpha
		g2.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 1f));
		//Debug
//		g2.setFont(new Font("Arial",Font.PLAIN, 26));
//		g2.setColor(Color.white);
//		g2.drawString("Invincible: "+ invincibleCounter, 10, 400);
	}
}