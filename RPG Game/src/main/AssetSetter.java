package main;

import entity.monster.MON_GreenSlime;
import entity.npc.NPC_OldMan;
import entity.object.OBJ_Axe;
import entity.object.OBJ_Coin_Bronze;
import entity.object.OBJ_Heart;
import entity.object.OBJ_ManaCrystal;
import entity.object.OBJ_Potion_Red;
import entity.object.OBJ_Shield_Blue;

public class AssetSetter {

	GamePanel gp;
	
	public AssetSetter(GamePanel gp) {
		this.gp = gp;
	
	}
	public void setObject() {
		
		int mapNum = 0;
		int i = 0;
//		gp.obj[mapNum][i] = new OBJ_Chest(gp);
//		gp.obj[mapNum][i].worldX = gp.TileSize*17;
//		gp.obj[mapNum][i].worldY = gp.TileSize*11;
//		i++;
		gp.obj[mapNum][i] = new OBJ_Potion_Red(gp);
		gp.obj[mapNum][i].worldX = gp.TileSize*11;
		gp.obj[mapNum][i].worldY = gp.TileSize*9;
		i++;
		gp.obj[mapNum][i] = new OBJ_Axe(gp);
		gp.obj[mapNum][i].worldX = gp.TileSize*12;
		gp.obj[mapNum][i].worldY = gp.TileSize*9;
		i++;
		mapNum = 1;
		gp.obj[mapNum][i] = new OBJ_Shield_Blue(gp);
		gp.obj[mapNum][i].worldX = gp.TileSize*21;
		gp.obj[mapNum][i].worldY = gp.TileSize*28;
		i++;

//		gp.obj[mapNum][i] = new OBJ_Shield_Blue(gp);
//		gp.obj[mapNum][i].worldX = gp.TileSize*11;
//		gp.obj[mapNum][i].worldY = gp.TileSize*9;
//		i++;
//		gp.obj[mapNum][i] = new OBJ_Potion_Red(gp);
//		gp.obj[mapNum][i].worldX = gp.TileSize*10;
//		gp.obj[mapNum][i].worldY = gp.TileSize*9;
//		i++;
//		gp.obj[1] = new OBJ_Door(gp);
//		gp.obj[1].worldX = gp.TileSize*23;
//		gp.obj[1].worldY = gp.TileSize*25;
	}
	public void setNPC() {
		int mapNum = 0;
		gp.NPC[mapNum][0] = new NPC_OldMan(gp);
		gp.NPC[mapNum][0].worldX = gp.TileSize*11;
		gp.NPC[mapNum][0].worldY = gp.TileSize *12;
	}
	
	public void setMonster() {
		
		 int i = 0;
		 int mapNum = 0;
		 gp.monster[mapNum][i] = new MON_GreenSlime(gp);
			gp.monster[mapNum][i].worldX = gp.TileSize* 11;
			gp.monster[mapNum][i].worldY = gp.TileSize* 10;
			i++;		 
		mapNum = 1;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 21;
		gp.monster[mapNum][i].worldY = gp.TileSize* 28;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 23;
		gp.monster[mapNum][i].worldY = gp.TileSize* 25;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 27;
		gp.monster[mapNum][i].worldY = gp.TileSize* 20;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 27;
		gp.monster[mapNum][i].worldY = gp.TileSize* 28;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 30;
		gp.monster[mapNum][i].worldY = gp.TileSize* 20;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 81;
		gp.monster[mapNum][i].worldY = gp.TileSize* 24;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 84;
		gp.monster[mapNum][i].worldY = gp.TileSize* 28;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 89;
		gp.monster[mapNum][i].worldY = gp.TileSize* 22;
		i++;
		mapNum ++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 30;
		gp.monster[mapNum][i].worldY = gp.TileSize* 27;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 33;
		gp.monster[mapNum][i].worldY = gp.TileSize* 38;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 54;
		gp.monster[mapNum][i].worldY = gp.TileSize* 39;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 56;
		gp.monster[mapNum][i].worldY = gp.TileSize* 60;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 32;
		gp.monster[mapNum][i].worldY = gp.TileSize* 67;
		i++;
		gp.monster[mapNum][i] = new MON_GreenSlime(gp);
		gp.monster[mapNum][i].worldX = gp.TileSize* 14;
		gp.monster[mapNum][i].worldY = gp.TileSize* 87;
		i++;
	}
}
