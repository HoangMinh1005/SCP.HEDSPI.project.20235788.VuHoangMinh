package entity.object;

import entity.Entity;
import main.GamePanel;

public class OBJ_Shield_Blue extends SuperObjects{

	public OBJ_Shield_Blue(GamePanel gp) {
		super(gp);
		
		type = type_shield;
		name = "Blue Shield";
		down1 = setup("/objects/shield_blue", gp.TileSize, gp.TileSize);
		defenseValue = 3;
		description = "[" + name + "]\nshiny shield."; 
	}

}
