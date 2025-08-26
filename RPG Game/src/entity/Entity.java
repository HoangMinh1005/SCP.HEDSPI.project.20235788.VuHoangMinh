package entity;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.Rectangle;
import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;

import entity.object.SuperObjects;
import entity.projectile.Projectile;
import main.GamePanel;
import main.UtilityTool;

public abstract class Entity {

	protected GamePanel gp;
	
	public BufferedImage up1, up2, down1, down2, right1, right2, left1, left2;
	public BufferedImage attackUp1, attackUp2, attackDown1, attackDown2, attackLeft1, attackLeft2, attackRight1, attackRight2;
	public Rectangle solidArea = new Rectangle(0,0,48,48);
	public Rectangle attackArea = new Rectangle( 0, 0, 0 ,0);
	public int solidAreaDefaultX, solidAreaDefaultY;
	protected String dialogue[] = new String[20];
	public BufferedImage image,  image2, image3;
	public boolean collision = false;
	
	//state
	public String direction = "down";
	public int worldX, worldY;
	public int spriteNum = 1;
	protected int dialogueIndex = 0;
	public boolean invincible = false;
	public boolean collisionOn = false;
	public boolean attacking = false;
	public boolean alive = true;
	public boolean dying = false;
	public boolean hpBarOn = false;
	
	//counter
	public int spriteCounter = 0;
	public int actionLockCounter = 0;
	public int invincibleCounter = 0;
	public int shotAvailableCounter = 0;
	
	//Character status
	public int maxLife;
	public int life;
	public int speed;
	public String name;
	public int attack;
	public int defense;
	public int exp;
	public int maxMana;
	public int mana;
	
	//item attributes
	public int attackValue;
	public int defenseValue;
	public String description = "";
	public int useCost;
	public int value; 
	
	//type
	public int type; //0 is player, 1 is npc, 2 is mons
	public final int type_player = 0;
	public final int type_npc = 1;
	public final int type_monster = 2;
	public final int type_sword = 3;
	public final int type_axe = 4;
	public final int type_shield = 5;
	public final int type_consumable = 6;
	public final int type_pickupOnly = 7;
	
	public Entity(GamePanel gp) {
	this.gp = gp;
	}		
	public void draw(Graphics2D g2) {}
	
	public void changeAlpha(Graphics2D g2, float alphaValue) {
			g2.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER, alphaValue));
		}
	public BufferedImage setup(String imagePath, int width, int height) {
		
		UtilityTool uTool = new UtilityTool();
		BufferedImage Image = null;
		
		try {
			Image = ImageIO.read(getClass().getResourceAsStream(imagePath + ".png"));
			Image = uTool.scaleImage(Image, width, height);
		}catch(IOException e) {
			e.printStackTrace();
		}
		return Image;
	}
}
