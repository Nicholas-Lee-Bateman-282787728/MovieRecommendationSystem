import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


public class MovieData {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws Exception {
		List<String> genreSet = processInputFiles();
		generateInputDataFiles(genreSet);
	}
	/**
	 * Function that generates the input data file
	 * @param inputSet - The list of all possible genres sorted
	 */
	public static void generateInputDataFiles(List<String> inputSet) throws Exception {
		HashMap<String, String> IdMovieMap = new HashMap<String, String>();
		File f = new File("ID-Movie HashMap");
		if (f.isFile() && f.exists()) {
			ObjectInputStream ois = new ObjectInputStream(new FileInputStream(f));
			IdMovieMap = (HashMap<String, String>)ois.readObject();
			System.out.println("Reading hash map");
		} else {
			System.out.println("Creating hash map");
			IdMovieMap = createIDMovieHashMap();
		}
		String[][] inputData = new String[1650][inputSet.size() + 2];
		// Inititalize array to zero
		for (int i = 0; i<1650; i++) {
			for (int j = 0; j < inputSet.size() + 2; j++) {
				inputData[i][j] = "0";
			}
		}
		boolean genreDone, directorDone, castDone, plotKeywordsDone;
		for (int i = 0; i <= 1649; i++) {
			String fileName = "Movie Data/" + i + ".Main";
			BufferedReader brRead;
			try {
				brRead = new BufferedReader(new FileReader(fileName));
			} catch (FileNotFoundException e) {
				// File doesn't exist
				inputData[i][0] = "-1";
				continue;
			}
			String s = brRead.readLine();
//			System.out.println(s);
//			System.out.println(i);
			genreDone = false;
			directorDone = true;
			castDone = true;
			plotKeywordsDone = false;
			// Inititalize movie ID
			inputData[i][0] = ""+i;
			// Inititalize various inputs
			while (true) {
				if (s.startsWith("DIRECTOR") && !directorDone) {
					ArrayList<String> genreList = new ArrayList<String>();
					genreList = new ArrayList<String>(Arrays.asList(s.split(" ")));
					for (int j = 0; j < genreList.size(); j++) {
						String genre = genreList.get(j).toLowerCase();
						if (inputSet.contains(genre)) {
							inputData[i][inputSet.indexOf(genre)+1] = "1";
						}
					}
					directorDone = true;
				} else if (s.startsWith("GENRE") && !genreDone) {
					ArrayList<String> genreList = new ArrayList<String>();
					genreList = new ArrayList<String>(Arrays.asList(s.split(" ")));
					Collections.sort(genreList);
					String genreLabel = "";
					for (int j = 1; j < genreList.size(); j++) {
						String genre = genreList.get(j).toLowerCase();
						genreLabel = genreLabel + genre;
						if (inputSet.contains(genre)) {
							inputData[i][inputSet.indexOf(genre)+1] = "1";
						}
					}
					genreLabel = genreLabel.replaceAll("sci_fi", "scifi");
					inputData[i][inputSet.size()+1] = genreLabel;
					genreDone = true;
				} else if (s.startsWith("CAST") && !castDone) {
					ArrayList<String> genreList = new ArrayList<String>();
					genreList = new ArrayList<String>(Arrays.asList(s.split(" ")));
					for (int j = 0; j < genreList.size(); j++) {
						String genre = genreList.get(j).toLowerCase();
						if (inputSet.contains(genre)) {
							inputData[i][inputSet.indexOf(genre)+1] = "1";
						}
					}
					castDone = true;
				} else if (s.startsWith("PLOT_KEYWORDS") && !plotKeywordsDone) {
					ArrayList<String> genreList = new ArrayList<String>();
					genreList = new ArrayList<String>(Arrays.asList(s.split(" ")));
					for (int j = 0; j < genreList.size(); j++) {
						String genre = genreList.get(j).toLowerCase();
						if (inputSet.contains(genre)) {
							inputData[i][inputSet.indexOf(genre)+1] = "1";
						}
					}
					plotKeywordsDone = true;
				}
				s = brRead.readLine();
				if (genreDone && directorDone && castDone && plotKeywordsDone) {
					break;
				}
			}
			brRead.close();
		}
		// Write to File normal
		String outputFileName = "Input Data.txt";
		BufferedWriter brWrite = new BufferedWriter(new FileWriter(outputFileName));
		for (int i = 0; i <= 1649; i++) {
			brWrite.write(inputData[i][0]);
			for (int j = 1; j < inputSet.size() + 2; j++) {
				brWrite.write(" " + inputData[i][j]);
			}
			brWrite.newLine();
		}
		brWrite.close();
		// Write to File for MATLAB
		outputFileName = "Input Data Matlab.txt";
		brWrite = new BufferedWriter(new FileWriter(outputFileName));
		for (int i = 1; i < inputSet.size() + 2; i++) {
			for (int j = 1; j <= 1649; j++) {
				brWrite.write(" " + inputData[j][i]);
			}
			brWrite.newLine();
		}
		brWrite.close();
		// Write to file for SOM Toolbox
//		HashSet<String> movies = new HashSet<String>();
		outputFileName = "Input Data SOM toolbox.data";
		brWrite = new BufferedWriter(new FileWriter(outputFileName));
		brWrite.write(""+inputSet.size());
		brWrite.newLine();
		brWrite.write("#n");
		for (int i = 0; i < inputSet.size(); i++) {
			brWrite.write(" "+inputSet.get(i));
		}
		brWrite.newLine();
		for (int i = 0; i <= 1649; i++) {
			if (inputData[i][0] == "-1") {
				continue;
			}
			brWrite.write(inputData[i][1]);
			for (int j = 2; j < inputSet.size() + 2; j++) {
				brWrite.write(" " + inputData[i][j]);
			}
			brWrite.write(" "+inputData[i][0]);
//			movies.add(inputData[i][0]);
			brWrite.newLine();
		}
		brWrite.flush();
		brWrite.close();
//		for (String id : IdMovieMap.keySet()) {
//			if (!movies.contains(id)) {
//				System.out.println(id);
//			}
//		}
		
		
		// Write to file for SOM Toolbox with Movie Names as labels
//		outputFileName = "Input Data SOM toolbox Movie Names.data";
//		brWrite = new BufferedWriter(new FileWriter(outputFileName));
//		brWrite.write(""+inputSet.size());
//		brWrite.newLine();
//		brWrite.write("#n");
//		for (int i = 0; i < inputSet.size(); i++) {
//			brWrite.write(" "+inputSet.get(i));
//		}
//		brWrite.newLine();
//		for (int i = 0; i <= 1649; i++) {
//			if (inputData[i][0] == "-1") {
//				continue;
//			}
//			brWrite.write(inputData[i][1]);
//			for (int j = 2; j < inputSet.size() + 2; j++) {
//				brWrite.write(" " + inputData[i][j]);
//			}
//			brWrite.write(" " + inputData[i][0]);
//			brWrite.write(" " + IdMovieMap.get(inputData[i][0]));
//			brWrite.newLine();
//		}
//		brWrite.flush();
//		brWrite.close();
		// Write to File for MATLAB
		outputFileName = "Input Data Matlab Movie Names.txt";
		brWrite = new BufferedWriter(new FileWriter(outputFileName));
		ArrayList<String> keyList = new ArrayList<String>();
		keyList.addAll(IdMovieMap.keySet());
		ArrayList<Integer> keyInts = new ArrayList<Integer>();
		for (String key : keyList) {
			keyInts.add(Integer.parseInt(key));
		}
		Collections.sort(keyInts);
		for (int key : keyInts) {
			if (!IdMovieMap.containsKey(""+key)) {
				continue;
			}
//			brWrite.write(inputData[i][0]);
			brWrite.write(IdMovieMap.get(""+key));
			brWrite.newLine();
		}
		brWrite.close();
		outputFileName = "Input Data Matlab Movie IDs.txt";
		brWrite = new BufferedWriter(new FileWriter(outputFileName));
		for (int key : keyInts) {
			if (!IdMovieMap.containsKey(""+key)) {
				continue;
			}
			brWrite.write(""+key);
//			brWrite.write(IdMovieMap.get(""+key));
			brWrite.newLine();
		}
		brWrite.close();
		outputFileName = "Movie IDs in SOM.txt";
		brWrite = new BufferedWriter(new FileWriter(outputFileName));
		for (int i = 0; i <= 1649; i++) {
			if (inputData[i][0] == "-1") {
				continue;
			}
			brWrite.write(inputData[i][0]);
			brWrite.newLine();
		}
		brWrite.close();
		System.out.println("Exiting generateInputDataFiles");
	}
	
	/**
	 * Function which generates the list of all possible genres from the movies
	 * @return Set of strings of various genres sorted in alphabetical order
	 * @throws IOException
	 */
	public static List<String> processInputFiles() throws IOException {
		List<String> allDirectors = new ArrayList<String>();
		List<String> allGenres = new ArrayList<String>();
		List<String> allCasts = new ArrayList<String>();
		List<String> allPlotKeywords = new ArrayList<String>();
		List<String> allWords = new ArrayList<String>();
		List<String> allWordsUnique = new ArrayList<String>();
		for (int i = 1; i <= 1649; i++) {
			String fileName = "Movie Data/" + i + ".Main";
			BufferedReader brRead;
			try {
				brRead = new BufferedReader(new FileReader(fileName));
			} catch (FileNotFoundException e) {
				continue;
			}
			List<String> director;
			List<String> genre;
			List<String> cast;
			List<String> plotKeywords;
			String s = brRead.readLine();
			while (!s.startsWith("IMDB_RECOMMENDATIONS")) {
				ArrayList<String> temp = new ArrayList<String>();
				if (s.startsWith("DIRECTOR")) {
					temp = new ArrayList<String>(Arrays.asList(s.split(" ")));
					for (int j = 0; j < temp.size(); j++) {
						String word = temp.get(j);
						temp.set(j, word.toLowerCase());
					}
					director = temp.subList(1, 2);
					allDirectors.addAll(director);
				} else if (s.startsWith("GENRE")) {
					temp = new ArrayList<String>(Arrays.asList(s.split(" ")));
					for (int j = 0; j < temp.size(); j++) {
						String word = temp.get(j);
						temp.set(j, word.toLowerCase());
					}
					genre = temp.subList(1, temp.size());
					allGenres.addAll(genre);
				} else if (s.startsWith("CAST")) {
					temp = new ArrayList<String>(Arrays.asList(s.split(" ")));
					for (int j = 0; j < temp.size(); j++) {
						String word = temp.get(j);
						temp.set(j, word.toLowerCase());
					}
					cast = temp.subList(1, temp.size());
					allCasts.addAll(cast);
				} else if (s.startsWith("PLOT_KEYWORDS")) {
					temp = new ArrayList<String>(Arrays.asList(s.split(" ")));
					for (int j = 0; j < temp.size(); j++) {
						String word = temp.get(j);
						temp.set(j, word.toLowerCase());
					}
					plotKeywords = temp.subList(1, temp.size());
					allPlotKeywords.addAll(plotKeywords);
				}
				s = brRead.readLine();
			}
			brRead.close();
		}
		//Combine all words
//		allWords.addAll(allDirectors);
		allWords.addAll(allGenres);
//		allWords.addAll(allCasts);
		allWords.addAll(allPlotKeywords);
		// Remove Duplicate Words
		HashMap<String, Integer> duplicateMap = new HashMap<String, Integer>();
		for (String word : allWords) {
			if (duplicateMap.containsKey(word)) {
				duplicateMap.put(word, duplicateMap.get(word) + 1);
			} else {
				duplicateMap.put(word, 1);
			}
		}
		allWordsUnique.addAll(duplicateMap.keySet());
		Collections.sort(allWordsUnique);
		// Write to file
		String outputFileName = "All Words.txt";
		String outputFileName2 = "All Words Unique.txt";
		BufferedWriter brWrite = new BufferedWriter(new FileWriter(outputFileName));
		BufferedWriter brWrite2 = new BufferedWriter(new FileWriter(outputFileName2));
		for (String word : allWordsUnique) {
			brWrite2.write(word);
			brWrite2.newLine();
		}
		for (String word : allWords) {
			brWrite.write(word);
			brWrite.newLine();
		}
		brWrite.close();
		brWrite2.close();
		System.out.println("Exiting process input files");
		return allWordsUnique;
	}
	
	public static HashMap<String, String> createIDMovieHashMap() throws Exception {
		HashMap<String, String> IdMovieMap = new HashMap<String, String>();
		File f = new File("ID-Movie HashMap");
		BufferedReader br = new BufferedReader(new FileReader("Movie.txt"));
		PrintWriter pr = new PrintWriter("ID-Movie.txt", "UTF-8");
		ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("ID-Movie HashMap"));
		while (true) {
			String input = br.readLine();
			if (input == null) {
				break;
			}
			String[] inputs = input.split("\t");
			pr.write(inputs[0]);
			pr.write("\t"+inputs[1]);
			pr.println();
			IdMovieMap.put(inputs[0], inputs[1]);
		}
		pr.flush();
		pr.close();
		br.close();
		oos.writeObject(IdMovieMap);
		oos.flush();
		oos.close();
		System.out.println("Exiting Create hashmap");
		return IdMovieMap;
	}
}
