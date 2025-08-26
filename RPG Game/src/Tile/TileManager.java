package Tile;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import javax.imageio.ImageIO;

import main.GamePanel;
import main.UtilityTool;

public class TileManager {

	GamePanel gp;
	public Tile[] tile;
	public int mapTileNum[][][];
	
	public TileManager(GamePanel gp) {
		 this.gp = gp;
		  
		 tile = new Tile[100];
		 mapTileNum = new int[gp.maxMap][gp.maxWorldCol][gp.maxWorldRow];
		 
		 getTileImage();
		 loadMap("/maps/ConSongQue.txt", 2);
		 loadMap("/maps/map1_final.txt", 0);
		 loadMap("/maps/map2.txt", 1);
	}
	
	public void getTileImage() {
	
			setup(0,"Floor1", false);
			setup(1,"Floor2", false);
			setup(2,"Wall", true);
			setup(3,"DoorOpened", false);
			setup(4,"DoorClosed", false);
			setup(5,"Exit", false);
			setup(6,"CageWall", true);
			setup(7,"CageDoorClosed", false);
			setup(8,"CageDoorOpened", false);
			setup(9,"CageDoorOpened", false);
			setup(10,"BedInCage", true);
			setup(11,"SparkingEquipment", false);
			setup(12,"Corpse", false);
			setup(13,"BedInCage", true);
			setup(14,"BloodPool1", false);
			setup(15,"BloodPool2", false);
			setup(16,"Warning Sign ", false);	
		
			setup(17,"dirt1", false);
			setup(18,"dirt2", false);
			setup(19,"grass2", false);
			setup(20,"dead2", false);
			setup(22,"fire2", false);
			setup(23,"hole2", true);
			setup(24,"water", false);
			setup(25,"tree1", true);
			setup(26,"Exit2", false);
			
			setup(27,"DatTrong", false);
			setup(28,"Nuoc", false);
			setup(29,"VungNuoc", false);
			setup(30,"CaChet", false);
			setup(31,"XuongHaMa", true);
			setup(32,"Mau", false);
			setup(33,"Cay", true);
			setup(34,"grass", false);
			setup(35,"ManhTren", false);
			setup(36,"Ongthai", false);
			setup(37,"CoUa", false);
			setup(38,"CayBiChat", false);
			setup(39,"hole", false);
			setup(40,"fire", false);
	}
	
	
	public void setup(int index, String imageName, boolean collision) {
		
		UtilityTool uTool = new UtilityTool();
		
		try {
			
			tile[index] = new Tile();
			tile[index].image = ImageIO.read(getClass().getResourceAsStream("/tiles/"+ imageName + ".png"));
			tile[index].image = uTool.scaleImage(tile[index].image, gp.TileSize, gp.TileSize);
			tile[index].collision = collision;
			
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public void loadMap(String filePath, int map) {
		
		try {
			InputStream is = getClass().getResourceAsStream(filePath);
			BufferedReader br = new BufferedReader(new InputStreamReader(is));
			
			int col = 0;
			int row = 0;
			
			while(col < gp.maxWorldCol && row < gp.maxWorldRow) {
				
				String line = br.readLine();
				
				while(col < gp.maxWorldCol) {
					
					String numbers[] = line.split(" ");
					
					int num = Integer.parseInt(numbers[col]);
					
					mapTileNum[map][col][row] = num;
					col++;
				}
				if(col == gp.maxWorldCol) {
					col = 0;
					row++;
				}
			}
			br.close();
			
		}catch(Exception e) {
			
		}
		
		
	}
	public void draw(Graphics2D g2) {
		
		int worldCol = 0;
		int worldRow = 0;

		
		while(worldCol < gp.maxWorldCol && worldRow < gp.maxWorldRow) {
			
			int tileNum = mapTileNum[gp.currentMap][worldCol][worldRow];
				

			int worldX = worldCol * gp.TileSize;
			int worldY = worldRow * gp.TileSize;
			int screenX = worldX - gp.player.worldX + gp.player.screenX;
			int screenY = worldY - gp.player.worldY + gp.player.screenY;
			
			if(worldX + gp.TileSize > gp.player.worldX - gp.player.screenX 
				&& worldX - gp.TileSize < gp.player.worldX + gp.player.screenX
				&& worldY + gp.TileSize > gp.player.worldY - gp.player.screenY 
				&& worldY - gp.TileSize < gp.player.worldY + gp.player.screenY) {
			
				g2.drawImage(tile[tileNum].image, screenX, screenY, null);
			
			}
			
					worldCol++;
			
			if(worldCol == gp.maxWorldCol) {
				worldCol = 0;
				worldRow++;
			}
		}
	}
}

























