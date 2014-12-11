function [ MovieSet, BMUSet ] = CollectMoviesForComparison( inputMovies, sM, sD, n, collectionMethod )
%COLLECTMOVIESFORCOMPARISON Collect 2n movies for comparison against the
%input movies, based on the collectionMethod specified.
%   Detailed explanation goes here

[V,I] = som_divide(sM, sD);
MovieSet = [];
BMUSet = [];
inputMoviesSize = size(inputMovies,1);
kCounter = 1;

if strcmp(collectionMethod,'individual')    
    while size(MovieSet,1) < (2*n)
        for i = 1:inputMoviesSize
            BMU = som_bmus(sM, inputMovies(i,:), kCounter);
            BMUSet(end+1,1) = BMU;
            MovieSet = [MovieSet; I{BMU}];
        end;
        kCounter = kCounter+1;
        BMUSet = unique(BMUSet);
        MovieSet = unique(MovieSet);
    end;
elseif strcmp(collectionMethod,'combinedto1')
    % Need to decide whether to clamp combinedInput or not. 
    combinedInput = sum(inputMovies);
    gtOne = find(combinedInput>1);
    for i=1:length(gtOne)
        combinedInput(gtOne(i)) = 1;
    end;
    while size(MovieSet,1) < (2*n)
        BMU = som_bmus(sM, combinedInput, kCounter);
        BMUSet(end+1, 1) = BMU;
        MovieSet = [MovieSet; I{BMU}];
        kCounter = kCounter+1;
    end;
    BMUSet = unique(BMUSet);
    MovieSet = unique(MovieSet);
elseif strcmp(collectionMethod,'combined')
    % Need to decide whether to clamp combinedInput or not. 
    combinedInput = sum(inputMovies);
    while size(MovieSet,1) < (2*n)
        BMU = som_bmus(sM, combinedInput, kCounter);
        BMUSet(end+1, 1) = BMU;
        MovieSet = [MovieSet; I{BMU}];
        kCounter = kCounter+1;
    end;
    BMUSet = unique(BMUSet);
    MovieSet = unique(MovieSet);
end;

end

