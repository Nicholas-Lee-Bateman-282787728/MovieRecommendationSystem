public class Tuple<X, Y> implements Comparable<Tuple<X, Y>>{
	public X movieName;
	public Y movieID;
	public Tuple(X movieName, Y movieId) {
		this.movieName = movieName;
		this.movieID = movieId;
	}
	
	@Override
	public String toString() {
		return this.movieID + " : " + this.movieName;
	}

	@Override
	public int compareTo(Tuple<X, Y> o) {
		return ((Integer)this.movieID).compareTo((Integer)o.movieID);
	}
}
