function [ finalMatrix ] = make_predictions1(sM, sD, inputMovies, n)
% MAKE_PREDICTIONS Accept a matrix containing vector representations of
% input movies, and return a list of n movie predictions.
% Makes predictions by taking all movies from the BMUs and collecting the
% ones with minimum distance to any of the input movies.
% Collects 2n movies in total from the BMUs of each input movie
% progressively increasing from the first BMU.
% inputMovies entered can be normalized or un-normalized. sD should match
% the normalization of inputMovies.
% sM should have been generated using inputMovies normalization techinique
% if any.

[V,I] = som_divide(sM, sD);
MovieSet = [];
BMUSet = [];
kCounter = 1;
inputMoviesSize = size(inputMovies,1);
while size(MovieSet,1) < (1.5*n)
    for i = 1:inputMoviesSize
        BMU = som_bmus(sM, inputMovies(i,:), kCounter);
        BMUSet(end+1,1) = BMU;
        MovieSet = [MovieSet; I{BMU}];
    end;
    BMUSet = unique(BMUSet);
    MovieSet = unique(MovieSet);
    kCounter = kCounter+1;
end;
%size(MovieSet,1)
%size(BMUSet,1)
%MovieSet
%kCounter
% '2' contains the movie ID in sD.labels
distanceMatrix = zeros(1,1+inputMoviesSize);
count=0;
MovieSetSize = size(MovieSet,1);
for i=1:MovieSetSize
    movieID = MovieSet(i,1);
    movieVector = sD.data(movieID,:);
    distances=zeros(1,inputMoviesSize);
    for j = 1:inputMoviesSize
        inputMovieVector = inputMovies(j,:);
        if inputMovieVector==movieVector
            distances(1,:) = [inf];
            count=count+1;
            break;
        else
            distances(1,j) = som_eucdist2(movieVector,inputMovieVector);
        end;
    end;
    distances = sort(distances);
    distanceMatrix(end+1,1) = movieID;
    distanceMatrix(end,2:end) = distances;
end;
% MovieSetSize
% count
% size(distanceMatrix)
% BMUs
resultMatrix = sortrows(distanceMatrix,2);
%resultMatrix(1:10,:)
tempMatrix = resultMatrix;
nonZeroIndex = find(tempMatrix(:,1)~=0,1);
resultMatrix = tempMatrix(nonZeroIndex:end,:);
numberOfResults = length(resultMatrix);
if(numberOfResults > n)
    resultMatrix = resultMatrix(1:n,1:2);
end;
finalMatrix = resultMatrix;
return;
end

