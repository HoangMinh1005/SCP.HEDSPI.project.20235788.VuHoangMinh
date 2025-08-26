package entity.object;

import entity.Entity;
import main.GamePanel;

public class OBJ_Sword_Normal extends SuperObjects{

	public OBJ_Sword_Normal(GamePanel gp) {
		super(gp);
		
		type =  type_sword;
		name = "Normal Sword";
		down1 = setup("/objects/sword",  gp.TileSize, gp.TileSize);
		attackValue = 1;
		attackArea.width = 36;
		attackArea.height = 36;
		description = "[" + name + "]\n An ancient sword."; 

	}

	
}
