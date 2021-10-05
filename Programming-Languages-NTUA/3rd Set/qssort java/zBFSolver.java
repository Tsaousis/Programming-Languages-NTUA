import java.util.*;

/* A class that implements a solver that explores the search space
 * using breadth-first search (BFS).  This leads to a solution that
 * is optimal in the number of moves from the initial to the final
 * state.
 */
public class zBFSolver implements zSolver {
  @Override
  public zState solve(zState initial) {

    Set<zState> seen = new HashSet<>();
    seen.add(initial);

    Queue<zState> remaining = new ArrayDeque<>();
    remaining.add(initial);

    while (!remaining.isEmpty()) {
      zState s = remaining.remove();
      if (s.isFinal())
        return s;

      for (zState n : s.next())
        if (!seen.contains(n)) {
          remaining.add(n);
          seen.add(n);
        }
    }
    return null;
  }
}        