import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import jxl.*;
import jxl.read.biff.BiffException;


public class UserMovieData {

	public static void main(String[] args) throws Exception {
		HashMap<String, ArrayList<Tuple<String, Integer>>> userMap = createUserDataMap();
//		writeUserDataForSOM(userMap);
		writeUserDataForReference(userMap);
	}

	private static HashMap<String, ArrayList<Tuple<String, Integer>>> createUserDataMap() throws IOException, BiffException {
		Workbook workbook = Workbook.getWorkbook(new File("Movie Test Data from Users.xls"));
		Sheet movieDataSheet = workbook.getSheet(0);
		int totalCols = movieDataSheet.getColumns();
		int filledCols = totalCols;
		int filledRows = 0;
		// Find no of columns of data
		for (int i = totalCols-1; i>=0; i--) {
			if (!movieDataSheet.getCell(i, 0).getContents().matches("\\s+|")) {
				filledCols = i+1;
				break;
			}
		}
		// Find no of rows of data
		for (int i = 2; i < movieDataSheet.getRows(); i++) {
			if (movieDataSheet.getCell(0, i).getContents().matches("\\s+|")) {
				filledRows = i;
				break;
			}
		}
		HashMap<String, ArrayList<Tuple<String, Integer>>> userData = new HashMap<String, ArrayList<Tuple<String,Integer>>>();
		// Gather data into array
		for (int col = 3; col < filledCols; col++) {
			ArrayList<Tuple<String, Integer>> movieIDs = new ArrayList<Tuple<String,Integer>>();
			for (int row = 2; row < filledRows; row++) {
//				System.out.println(col + " " + row);
//				System.out.println(movieDataSheet.getCell(col, 0).getContents()+"  "+row);
				int likes = (int)((NumberCell)movieDataSheet.getCell(col, row)).getValue();
				if (likes == 1) {
					Tuple<String, Integer> tuple = new Tuple<String, Integer>(movieDataSheet.getCell(1, row).getContents(), Integer.parseInt(movieDataSheet.getCell(0, row).getContents()));
					movieIDs.add(tuple);
//					System.out.print(movieDataSheet.getCell(0, row).getContents());
//					System.out.print(movieDataSheet.getCell(1, row).getContents());
				}
			}
			userData.put(movieDataSheet.getCell(col, 0).getContents(), movieIDs);
		}
		System.out.println("Exiting createUserDataMap");
		return userData;
	}
	
	public static void writeUserDataForSOM(HashMap<String, ArrayList<Tuple<String, Integer>>> userMap) throws Exception {
		String outputFileName = "User Movie Data SOM toolbox.txt";
		BufferedWriter brWrite = new BufferedWriter(new FileWriter(outputFileName));
		int maxSize = 0;
		for (String userName : userMap.keySet()) {
			ArrayList<Tuple<String, Integer>> movieList = userMap.get(userName);
			if (movieList.size() > maxSize) {
				maxSize = movieList.size();
			}
		}
		for (String userName : userMap.keySet()) {
			ArrayList<Tuple<String, Integer>> movieList = userMap.get(userName);
			Collections.shuffle(movieList);
			String write = "";
			for (int i = 0; i < maxSize; i++) {
				if (i < movieList.size()) {
					write = write + movieList.get(i).movieID + "\t";
				} else {
					write = write + "Nan" + "\t";
				}
			}
//			System.out.println(userName + ": " + write.substring(0, write.length()-1));
			brWrite.write(write.substring(0, write.length()-1));
			brWrite.newLine();
		}
		brWrite.flush();
		brWrite.close();
		System.out.println("Exiting writeUserDataForSOM");
	}
	
	public static void writeUserDataForReference(HashMap<String, ArrayList<Tuple<String, Integer>>> userMap) throws Exception {
		String outputFileName = "User Movie Data Reference.txt";
		BufferedWriter brWrite = new BufferedWriter(new FileWriter(outputFileName));
		int maxSize = 0;
		for (String userName : userMap.keySet()) {
			ArrayList<Tuple<String, Integer>> movieList = userMap.get(userName);
			if (movieList.size() > maxSize) {
				maxSize = movieList.size();
			}
		}
		for (String userName : userMap.keySet()) {
			ArrayList<Tuple<String, Integer>> movieList = userMap.get(userName);
			Collections.sort(movieList);
			String write = userName + "\t";
			for (int i = 0; i < maxSize; i++) {
				if (i < movieList.size()) {
					write = write + movieList.get(i).movieID + "\t";
				} else {
					write = write + "Nan" + "\t";
				}
			}
//			System.out.println(userName + ": " + write.substring(0, write.length()-1));
			brWrite.write(write.substring(0, write.length()-1));
			brWrite.newLine();
		}
		brWrite.flush();
		brWrite.close();
		System.out.println("Exiting writeUserDataForReference");
	}
}
