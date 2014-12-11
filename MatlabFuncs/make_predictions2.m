function [ finalMatrix ] = make_predictions2(sM, sD, inputMovies, n, collectionMethod)
% MAKE_PREDICTIONS Accept a matrix containing vector representations of
% input movies, and return a list of n movie predictions chosen from k best
% matching map units. 
% Making predictions by taking all movies from the BMUs and collecting the
% ones with minimum distance to any of the input movies.
% Collects 2n movies in total from the BMUs of each input movie
% progressively increasing from the first BMU.
% inputMovies entered can be normalized or un-normalized. sD should match
% the normalization of inputMovies.
% sM should have been generated using inputMovies normalization techinique
% if any.


inputMoviesSize = size(inputMovies,1);

[MovieSet, BMUSet] = CollectMoviesForComparison(inputMovies, sM, sD, n, collectionMethod);

distanceMatrix = zeros(1,1);
count=0;
MovieSetSize = size(MovieSet,1);
for i=1:MovieSetSize
    movieRowNo = MovieSet(i,1);
    movieVector = sD.data(movieRowNo,:);
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
    distanceMatrix(end+1,1) = movieRowNo;
    distanceMatrix(end,2) = sum(distances);
end;

% size(distanceMatrix,1)
% MovieSetSize
% count
% size(distanceMatrix)
% BMUs
resultMatrix = sortrows(distanceMatrix,2);
tempMatrix = resultMatrix;
nonZeroIndex = find(tempMatrix(:,1)~=0,1);
resultMatrix = tempMatrix(nonZeroIndex:end,:);
numberOfResults = length(resultMatrix);
if(numberOfResults > n)
    resultMatrix = resultMatrix(1:n,:);
end;
finalMatrix = resultMatrix;
return;
end
