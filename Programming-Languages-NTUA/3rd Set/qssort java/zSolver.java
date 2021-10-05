          
/* A generic interface for a solver that explores a state space,
 * starting from some initial space, aiming to reach some desired
 * final state.
 */
public interface zSolver {
  // Returns the solution or null if there is none.
  public zState solve(zState initial);
}
        