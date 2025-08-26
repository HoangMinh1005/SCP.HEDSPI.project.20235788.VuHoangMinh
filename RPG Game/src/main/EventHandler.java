package main;

public class EventHandler {

	GamePanel gp;
	EventRect eventRect[][][];
	
	int previousEventX, previousEventY;
	boolean canTouchEvent = true;
	
	public EventHandler(GamePanel gp) {
		this.gp = gp;
		
		eventRect = new EventRect[gp.maxMap][gp.maxWorldCol][gp.maxWorldRow];
		
		int map = 0;
		int col = 0;
		int row = 0;
		while(map < gp.maxMap && col<gp.maxWorldCol && row<gp.maxWorldRow) {
		
			eventRect[map][col][row] = new EventRect();
			eventRect[map][col][row].x = 23;
			eventRect[map][col][row].y = 23;
			eventRect[map][col][row].width = 2;
			eventRect[map][col][row].height = 2;
			eventRect[map][col][row].eventRectDefaultX = eventRect[map][col][row].x;
			eventRect[map][col][row].eventRectDefaultY = eventRect[map][col][row].y;
			
			col++;
			if(col == gp.maxWorldCol) {
				col = 0;
				row++;
				
				if(row == gp.maxWorldRow) {
					row = 0;
					map++;
				}
			}
		}
		
	}
	
	public void checkEvent() {
		
		//check if the player character is more than 1 tile away from the last event
		int xDistance = Math.abs(gp.player.worldX - previousEventX);
		int yDistance = Math.abs(gp.player.worldY - previousEventY);
		int distance = 	Math.max(xDistance, yDistance);
		if(distance> gp.TileSize) {
			canTouchEvent = true;
		}
		
		if(canTouchEvent == true) {
			
			if(hit(1,21,18,"any") == true) {damagePit(gp.dialogueState);}
			else if(hit (0,104,102,"any") == true) {teleport(1, 9,21);}
			else if(hit (0,104,103,"any") == true) {teleport(1, 9,22);}
			else if(hit (1, 7,21,"any") == true) {teleport(0,104,102);}
			else if(hit (1, 7,22,"any") == true) {teleport(0,104,103);}
			else if(hit (1,95,12,"any") == true) {teleport(2, 12,12);}
			else if(hit (1,95,11,"any") == true) {teleport(2, 12,11);}
			else if(hit (2,10,9,"any") == true) {teleport(1,95,12);}
			else if(hit (2,10,8,"any") == true) {teleport(1,95,11);}
		}
		
	}
	
	public boolean hit(int map, int col, int row, String reqDirection) {
		
		boolean hit = false;
		
		
		if(map == gp.currentMap) {
			gp.player.solidArea.x = gp.player.worldX + gp.player.solidArea.x;
			gp.player.solidArea.y = gp.player.worldY + gp.player.solidArea.y;
			eventRect[map][col][row].x = col * gp.TileSize + eventRect[map][col][row].x;
			eventRect[map][col][row].y = row * gp.TileSize + eventRect[map][col][row].y;
			if(gp.player.solidArea.intersects(eventRect[map][col][row]) && eventRect[map][col][row].eventDone == false ) {
				if(gp.player.direction.contentEquals(reqDirection) || reqDirection.contentEquals("any")) {
					hit = true;
					
					previousEventX = gp.player.worldX;
					previousEventY = gp.player.worldY;
				}
			}
			gp.player.solidArea.x = gp.player.solidAreaDefaultX;
			gp.player.solidArea.y = gp.player.solidAreaDefaultY;
			eventRect[map][col][row].x = eventRect[map][col][row].eventRectDefaultX;
			eventRect[map][col][row].y = eventRect[map][col][row].eventRectDefaultY;
		}
		
		return hit;
	}
	
	public void damagePit(int gameState) {
		
		gp.gameState = gameState;
		gp.ui.currentDialogue = "You stepped on fire!";
		gp.player.life -= 1;
//		eventRect[col][row].eventDone = true;
		canTouchEvent = false;
		
	}
	
	public void healingPool(int gameState) {
		
		if(gp.keyH.enterPressed == true) {
			gp.gameState = gameState;
			gp.player.attackCanceled = true;
			gp.ui.currentDialogue = "You listen to nhac Jack. \n You hoi` day mau.";
			gp.player.life = gp.player.maxLife;
			gp.player.mana = gp.player.maxMana;
			gp.aSetter.setMonster();
		}

	}
	
	public void teleport(int map, int col, int row) {
		gp.currentMap = map;
		gp.ui.currentDialogue = "Teleported";
		gp.player.worldX = gp.TileSize*col;
		gp.player.worldY = gp.TileSize*row;
		previousEventX = gp.player.worldX;
		previousEventY = gp.player.worldY;
		canTouchEvent = false;
	}
	

}



























