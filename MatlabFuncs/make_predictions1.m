function [ finalMatrix ] = make_predictions1(sM, sD, inputMovies, n, collectionMethod)
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

distanceMatrix = zeros(1,1+inputMoviesSize);
count=0;
MovieSetSize = size(MovieSet,1);

%Compare collected movies with 'combined movies' as that seems to be giving
%better results - this is now a replication of make_predictions2 and needs
%to be changed back to the original method of comparing with individual
%input movies. 
% combinedInput = sum(inputMovies);
% count=0;
% for i=1:MovieSetSize
%     movieID = MovieSet(i,1);
%     movieVector = sD.data(movieID,:);
%     match=0;
%     for j = 1:inputMoviesSize
%         inputMovieVector = inputMovies(j,:);
%         if inputMovieVector==movieVector
%             match=1;
%             count=count+1;
%             break;
%         end;
%     end;
%     if match == 1
%         distanceMatrix(end+1,1) = movieID;
%         distanceMatrix(end, 2) = inf;
%     else
%         distanceMatrix(end+1,1) = movieID;
%         distanceMatrix(end, 2) = som_eucdist2(movieVector, combinedInput);
%     end;
% end;

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
            distances(1,:) = [inf];
            count=count+1;
            break;
        else
            distances(1,j) = som_eucdist2(movieVector,inputMovieVector);
        end;
     end;
    distances = sort(distances);
    distanceMatrix(end+1,1) = movieRowNo;
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

