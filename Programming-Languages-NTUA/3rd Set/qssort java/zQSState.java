
import java.util.*;

/* A class implementing the state of the well-known problem with the
 * wolf, the goat and the cabbage.
 */
public class zQSState implements zState {
  // The positions of the four players; false = west and true = east.

  private List<Integer> que;
  private List<Integer> stac;
  private String camefrom;
  // The previous state.
  private zState previous;

  public zQSState(List<Integer> q, List<Integer> s, String stringi, zState p) {
    que = q;
    stac = s;
    camefrom = stringi;
    previous = p;
  }

  @Override
  public boolean isFinal() {

    if (stac.isEmpty()) {

      boolean ascending = true;
      for (int i = 1; i < que.size() && (ascending); i++) {
        ascending = ascending && que.get(i) >= que.get(i - 1);
      }
      return ascending;
    }

    return false;
  }

  @Override
  public boolean isBad() {
    return false;
  }

  @Override
  public Collection<zState> next() {
    Collection<zState> states = new ArrayList<>();

    if (stac.isEmpty()) {
      stac.add(que.remove(0));
      states.add(new zQSState(que, stac, "Q", this));
      return states;
    } else

    if (que.isEmpty()) {
      que.add(stac.remove(stac.size() - 1));
      states.add(new zQSState(que, stac, "S", this));
      return states;
    } else

    if (que.get(0) == stac.get(stac.size() - 1)) {
      stac.add(que.remove(0));
      states.add(new zQSState(que, stac, "Q", this));
      return states;
    } else {

      List<Integer> qque = new ArrayList<>(que);
      List<Integer> qstac = new ArrayList<>(stac);

      qstac.add(qque.remove(0));
      states.add(new zQSState(qque, qstac, "Q", this));
      // q

      que.add(stac.remove(stac.size() - 1));

      // s
      states.add(new zQSState(que, stac, "S", this));
      return states;
    }
  }

  @Override
  public zState getPrevious() {
    return previous;
  }

  @Override
  public String toString() {
    return camefrom;
  }

  // Two states are equal if all four are on the same shore.
  @Override
  public boolean equals(Object o) {
    if (this == o)
      return true;
    if (o == null || getClass() != o.getClass())
      return false;
    zQSState other = (zQSState) o;
    return que.equals(other.que)  && stac.equals(other.stac) ;
  }

  // Hashing: consider only the positions of the four players.
  @Override
  public int hashCode() {
    return Objects.hash(que, stac);
  }
}        