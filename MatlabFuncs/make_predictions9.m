function [ finalMatrix ] = make_predictions9(sM, sD, inputMovies, n, collectionMethod)
% MAKE_PREDICTIONS Accept a matrix containing vector representations of
% input movies, and return a list of n movie predictions chosen from k best
% matching map units. 
% Making predictions by taking all movies from the BMUs and picking the
% best ones. Takes the combinbed input and reduces it to 1. 
% inputMovies and sD should be in un-normalized format.
% sM should have been generated using un-normalized data.

%'cosine'


inputMoviesSize = size(inputMovies,1);

[MovieSet, BMUSet] = CollectMoviesForComparison(inputMovies, sM, sD, n, collectionMethod);

distanceMatrix = zeros(1,1+inputMoviesSize);
count=0;
MovieSetSize = size(MovieSet,1);
for i=1:MovieSetSize
    movieRowNo = MovieSet(i,1);
    movieVector = sD.data(movieRowNo,:);
    distances=zeros(1,inputMoviesSize);
    for j = 1:inputMoviesSize
        inputMovieVector = inputMovies(j,:);
        if inputMovieVector==movieVector
            distances(1,:) = [0];
            count=count+1;
            break;
        else
            distances(1,j) = dot(movieVector,inputMovieVector);
        end;
     end;
    distances = sort(distances);
    distances = fliplr(distances);
    distanceMatrix(end+1,1) = movieRowNo;
    distanceMatrix(end,2:end) = distances;
end;

% MovieSetSize
% count
% size(distanceMatrix)
% BMUs
resultMatrix = sortrows(distanceMatrix,2);
tempMatrix = resultMatrix;
nonZeroIndex = find(tempMatrix(:,1)~=0,1);
resultMatrix = tempMatrix(nonZeroIndex:end,:);
numberOfResults = length(resultMatrix);
resultMatrix = flipud(resultMatrix);
if(numberOfResults > n)
    resultMatrix = resultMatrix(1:n,1:2);
end;
finalMatrix = resultMatrix;
return;
end