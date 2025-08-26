package entity.object;


import entity.Entity;
import entity.player.Player;
import main.GamePanel;

public class OBJ_Heart extends SuperObjects{

	GamePanel gp;
	
	public OBJ_Heart(GamePanel gp) {
		
		super(gp);	
		this.gp = gp;
		
		type = type_pickupOnly;
		name = "Heart";
		value = 2;
		down1 = setup("/objects/heart_full", gp.TileSize, gp.TileSize);
		image = setup("/objects/heart_full", gp.TileSize, gp.TileSize);
		image2 = setup("/objects/heart_half", gp.TileSize, gp.TileSize);
		image3 = setup("/objects/heart_blank", gp.TileSize, gp.TileSize);
		
	}
	
	public void use(Entity entity) {
		
		gp.ui.addMessage("Life +" + value);
		entity.life += value;
	}
}
