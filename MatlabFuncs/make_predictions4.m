function [ finalMatrix ] = make_predictions4(sM, sD, inputMovies, n, collectionMethod)
%MAKE_PREDICTIONS Accept a matrix containing vector representations of
%input movies, and return a list of n movie predictions chosen from k best
%matching map units. 
% Making predictions by taking all movies from the BMUs and picking the
% best ones. Takes the combinbed input and reduces it to 1. 
% inputMovies and sD should be in un-normalized format.
% sM should have been generated using un-normalized data.

%'cosine'

% Combining input movies into one vector
combinedInput = sum(inputMovies);

% Clamping inputs - no value should be greater than 1
gtOne = find(combinedInput>1);
for i=1:length(gtOne)
    combinedInput(gtOne(i)) = 1;
end;

[MovieSet, BMUSet] = CollectMoviesForComparison(inputMovies, sM, sD, n, collectionMethod);
    
MovieSetSize = size(MovieSet,1);
inputMoviesSize = size(inputMovies,1);
distanceMatrix = zeros(1,2);
count=0;
for i=1:MovieSetSize
    movieRowNo = MovieSet(i,1);
    movieVector = sD.data(movieRowNo,:);
    match=0;
    for j = 1:inputMoviesSize
        inputMovieVector = inputMovies(j,:);
        if inputMovieVector==movieVector
            match=1;
            count=count+1;
            break;
        end;
    end;
    if match == 1
%         Don't insert repeating movies in the set
        distanceMatrix(end+1,1) = movieRowNo;
        distanceMatrix(end, 2) = inf;
    else
        distanceMatrix(end+1,1) = movieRowNo;
        distanceMatrix(end, 2) = pdist2(combinedInput, sD.data(movieRowNo,:), 'cosine');
    end;
end;
resultMatrix = sortrows(distanceMatrix,2);
% resultMatrix = flipud(resultMatrix);
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

