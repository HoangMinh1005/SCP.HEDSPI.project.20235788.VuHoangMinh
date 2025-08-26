package entity.object;

import entity.Entity;
import main.GamePanel;

public class OBJ_Coin_Bronze extends SuperObjects{

	GamePanel gp;
	
	public OBJ_Coin_Bronze(GamePanel gp) {
		super(gp);
		this.gp = gp;
		
		
		type = type_pickupOnly;
		name = " Bronze Coin";
		value = 1;
		down1 = setup("/objects/coin_bronze", gp.TileSize, gp.TileSize);
		
	}
	
	public void use(Entity entity) {
		
		gp.ui.addMessage("Coin +" + value);
		gp.player.coin += value;
	}

}
