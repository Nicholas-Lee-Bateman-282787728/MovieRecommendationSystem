numberOfCases = length(UserData(:,1));
%Configuration parameters
k = 5;  %Number of best matching map units to examine
n = 20; %Number of movie recommendations to return
for i=1:numberOfCases
    RecommendedMovies = RecommendMoviesForUser( i, UserData, sM, sD, k, n, 'addandreduceto1')