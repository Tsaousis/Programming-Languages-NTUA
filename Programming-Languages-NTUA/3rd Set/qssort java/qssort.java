import java.io.*;
import java.util.*;

public class QSsort {
  // The main function.
  public static void main(String args[]) {
    final long startTime = System.currentTimeMillis();
    try {

      List<Integer> holy_que = new ArrayList<Integer>();

      BufferedReader in = new BufferedReader(new FileReader(args[0]));
      in.readLine();

      String line2 = in.readLine();
      in.close();

      String[] words = line2.split(" ");// splits the string based on whitespace
      for (String w : words) {
        int number = Integer.parseInt(w);
        holy_que.add(number);
      }

      List<Integer> sorted_que = new ArrayList<>();
      List<Integer> empty_stac = new ArrayList<>();
      sorted_que.addAll(holy_que);

      Collections.sort(sorted_que);

      zSolver solver = new zBFSolver();
      zState initial = new zQSState(holy_que, empty_stac, "", null);
      zState result = solver.solve(initial);
      if (holy_que.equals(sorted_que)) {
        System.out.println("empty");
      } else {
        printSolution(result);
      }
      final long endTime = System.currentTimeMillis();    
      //System.out.println("\nTotal execution time: " + (endTime - startTime)); 
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  // A recursive function to print the states from the initial to the final.
  private static void printSolution(zState s) {
    if (s.getPrevious() != null) {
      printSolution(s.getPrevious());
    }
    System.out.print(s.toString());
  }
}
//sublist is o(1)             