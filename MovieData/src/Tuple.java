public class Tuple<X, Y> {
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
}
