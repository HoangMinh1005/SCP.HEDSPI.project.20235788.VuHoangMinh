package entity.object;

import entity.Entity;
import main.GamePanel;

public class OBJ_Axe extends SuperObjects{

	public OBJ_Axe(GamePanel gp) {
		super(gp);
		
		type = type_axe;
		name = "Axe";
		down1 = setup("/objects/axe", gp.TileSize, gp.TileSize);
		attackValue = 2;
		attackArea.width = 30;
		attackArea.height = 30;
		description = "[" + name + "]\nBetter than Sword.";
	}

}
