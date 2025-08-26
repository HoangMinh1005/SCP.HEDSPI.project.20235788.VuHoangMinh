package entity.object;

import entity.Entity;
import entity.player.Player;
import main.GamePanel;

public class OBJ_ManaCrystal extends SuperObjects{

	GamePanel gp;
	
	public OBJ_ManaCrystal(GamePanel gp) {
		super(gp);
		this.gp = gp;
		
		type = type_pickupOnly;
		value = 1;
		name = "Mana Crystal";
		down1 = setup("/objects/manacrystal_full", gp.TileSize, gp.TileSize);
		image2 = setup("/objects/manacrystal_blank", gp.TileSize, gp.TileSize);
		image = setup("/objects/manacrystal_full", gp.TileSize, gp.TileSize);
		
	}
	public void use(Entity entity) {
		
		gp.ui.addMessage("Mana +" + value);
		entity.mana = value;
	}

}
