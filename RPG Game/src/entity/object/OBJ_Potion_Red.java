package entity.object;

import entity.Entity;
import entity.player.Player;
import main.GamePanel;

public class OBJ_Potion_Red extends SuperObjects{

	GamePanel gp;	
	
	public OBJ_Potion_Red(GamePanel gp) {
		super(gp);
		
		this.gp=gp;
	
		type = type_consumable;
		name ="Red Potion";
		value = 5;
		down1 = setup("/objects/potion_red", gp.TileSize, gp.TileSize);
		description = "[" + name + "]\nHeals yor life by\n" + value + ".";
	}

	public void use(Entity entity) {
		
		gp.gameState = gp.dialogueState;
		gp.ui.currentDialogue = "You drink the " + name + "!\n" + "Your life has been recovered by " + value + ".";
		entity.life += value;
		if(gp.player.life > gp.player.maxLife ) {
			gp.player.life = gp.player.maxLife;
		}
		
	}
}
