function [ finalMatrix ] = make_predictions1(sM, sD, inputMovies, k, n)
%MAKE_PREDICTIONS Accept a matrix containing vector representations of
%input movies, and return a list of n movie predictions chosen from k best
%matching map units. 
% Making predictions by taking all movies from the BMUs and picking the
% best ones. Takes combined input and doesn't normalize or reduce to 1.
% inputMovies entered can be normalized or un-normalized. sD should match
% the normalization of inputMovies.
% sM should have been generated using inputMovies normalization techinique
% if any.

% Combining input movies into one vector
combinedInput = sum(inputMovies);

% Finding the top k BMUs for the combined input.
BMUs = som_bmus(sM, combinedInput, [1:k]);

[V,I] = som_divide(sM, sD);

% inputVector = sD.data(find(ismember(sD.labels(:,2), '42')),:);
% sum0 = 0;
% sum1 = 0;
% for i=1:3771
%     if(isempty(inputVector(i)))
%         i
%     elseif(inputVector(i)==1)
%         sum1=sum1+1;
%     elseif(inputVector(i)==0)
%         sum0=sum0+1;
%     end;
% end;
% sum0+sum1


%perBin = ceil(n/k) + 2;
% moreMovies = 0;
%I{BMUs(1)}

% '2' contains the movie ID in sD.labels
distanceMatrix = zeros(1,2);
for i=1:k
    movieBin = I{BMUs(i)};
    numberOfMovies = length(movieBin);
    total=total + numberOfMovies;
    for j=1:numberOfMovies
        movieID = movieBin(j);
        movieVector = sD.data(movieID,:);
        inputMatch = 0;
        inputMoviesNo = size(inputMovies,1);
        for k=1:inputMoviesNo
            if movieVector==inputMovies(k,:)
                inputMatch = 1;
                common=common+1;
                break;
            end
        end
        if inputMatch==0
            distanceMatrix(end+1,1) = movieID;
            distanceMatrix(end,2) = som_eucdist2(combinedInput, movieVector);
        end
    end;
    %Sort distance matrix on the basis of distance
end;
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

