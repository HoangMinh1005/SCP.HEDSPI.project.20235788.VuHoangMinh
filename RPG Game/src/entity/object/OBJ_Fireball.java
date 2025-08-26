package entity.object;

import entity.Entity;
import entity.player.Player;
import entity.projectile.Projectile;
import main.GamePanel;

public class OBJ_Fireball extends Projectile{
	
	GamePanel gp;

	public OBJ_Fireball(GamePanel gp) {
		super(gp);
		this.gp = gp;
		
		name = "Fireball";
		speed = 8;
		maxLife = 80;
		life = maxLife;
		attack = 2;
		useCost = 1;
		alive = false;
		getImage();
	}
	public void getImage() {
		up1 = setup("/projectile/fireball_up_1", gp.TileSize, gp.TileSize);
		up2 = setup("/projectile/fireball_up_2", gp.TileSize, gp.TileSize);
		down1 = setup("/projectile/fireball_down_1", gp.TileSize, gp.TileSize);
		down2 = setup("/projectile/fireball_down_2", gp.TileSize, gp.TileSize);
		left1 = setup("/projectile/fireball_left_1", gp.TileSize, gp.TileSize);
		left2 = setup("/projectile/fireball_left_2", gp.TileSize, gp.TileSize);
		right1 = setup("/projectile/fireball_right_1", gp.TileSize, gp.TileSize);
		right2 = setup("/projectile/fireball_right_2", gp.TileSize, gp.TileSize);
	}

	public boolean haveResource(Entity user) {
		
		boolean haveResource = false;
		if(user.mana >= useCost) {
			haveResource = true;
		}
		return haveResource;
	}
	
	public void subtractResource(Entity user) {
		user.mana -= useCost;
	}
}
