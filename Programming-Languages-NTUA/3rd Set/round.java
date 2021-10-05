
import java.io.*;
import java.util.*;

public class round {
    // The main function.
    public static void main(String args[]) {
        final long startTime = System.currentTimeMillis();
        try {
            Integer cities,cars;
            List<Integer> locations = new ArrayList<>();
            
            int j = 0;
            int max = 0;
            int sum = 0;

            Integer ulti_sum = Integer.MAX_VALUE;
            int ulti_cit = 90;

            int maxpointer = 0;

            //input
            while (true) {

                BufferedReader in = new BufferedReader(new FileReader(args[0]));
                String line1 = in.readLine();

                String line2 = in.readLine();
                in.close();

                String[] words2 = line2.split(" ");// splits the string based on whitespace
                String[] words1 = line1.split(" ");// splits the string based on whitespace

                 cities = Integer.parseInt(words1[0]);
                 cars = Integer.parseInt(words1[1]);

                

                for (String w : words2)
                    locations.add(Integer.parseInt(w));

                break;
            }
            
            //transform from locations to population
            int[] population = new int[cities];
            for (Integer i : locations) {
                population[i] += 1;
            }

            //find sum and max for city 0
            for (int i = 0; i < cars; i++) {

                int temp = j - locations.get(i);
                if (temp < 0)   temp += cities;

                sum += temp;
                if (temp > max) max = temp;
            }



            //main loop
            for (int mainpointer = 0; mainpointer < cities; mainpointer++) {
                
                //find max and maxpointer for every city
                for (int i = 1; i < cities; i++) {
                    if (population[(mainpointer + i) % cities] != 0) {
                        maxpointer = (mainpointer + i) % cities;
                        max = mainpointer - (mainpointer + i) % cities;
                        if (max < 0)
                            max += cities;
                        break;
                    }
                }

                //find new sum 
                if (mainpointer != 0) {
                    sum = sum + cars - (cities) * population[mainpointer];
                }

                //update result if needed
                if (sum < ulti_sum) {
                    if (sum - max - max >= -1) {
                        ulti_sum = sum;
                        ulti_cit = mainpointer;
                    }
                }
            }

            //print output
            while (true)    {
                System.out.print(ulti_sum);
                System.out.print(" ");
                System.out.println(ulti_cit);
                final long endTime = System.currentTimeMillis();
                //System.out.println("\nTotal execution time: " + (endTime - startTime));
                break;
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}     