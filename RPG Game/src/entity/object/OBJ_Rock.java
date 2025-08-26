package entity.object;

import entity.Entity;
import entity.monster.MON_GreenSlime;
import entity.projectile.Projectile;
import main.GamePanel;

public class OBJ_Rock extends Projectile{
	
	GamePanel gp;

	public OBJ_Rock(GamePanel gp) {
		super(gp);
		this.gp = gp;
		
		name = "Rock";
		speed = 8;
		maxLife = 50;
		life = maxLife;
		attack = 2;
		useCost = 1;
		alive = false;
		getImage();
	}
	public void getImage() {
		up1 = setup("/projectile/rock_down_1", gp.TileSize, gp.TileSize);
		up2 = setup("/projectile/rock_down_1", gp.TileSize, gp.TileSize);
		down1 = setup("/projectile/rock_down_1", gp.TileSize, gp.TileSize);
		down2 = setup("/projectile/rock_down_1", gp.TileSize, gp.TileSize);
		left1 = setup("/projectile/rock_down_1", gp.TileSize, gp.TileSize);
		left2 = setup("/projectile/rock_down_1", gp.TileSize, gp.TileSize);
		right1 = setup("/projectile/rock_down_1", gp.TileSize, gp.TileSize);
		right2 = setup("/projectile/rock_down_1", gp.TileSize, gp.TileSize);
	}
	public boolean haveResource(MON_GreenSlime user) {
		
		boolean haveResource = false;
		if(user.ammo >= useCost) {
			haveResource = true;
		}
		return haveResource;
	}
	
	public void subtractResource(MON_GreenSlime user) {
		user.ammo -= useCost;
	}
}
