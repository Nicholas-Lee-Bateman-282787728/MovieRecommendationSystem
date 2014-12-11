function [ RecMovies, RecMoviesRows ] = RecommendMoviesForUser( UserInputData, sMap, sData, n, predictionMethod, collectionMethod )
%GETPREDICTIONSFORUSER Summary of this function goes here
%   Need to take care of the normalized vs unnormalized case here -
%   currently most of the functions work for unnormalized data, not sure if
%   they will work as-is for normalized data. 
RecMovies = [];
RecMoviesRows = [];
if strcmp(predictionMethod,'minimumDistance')
    %Minimum of distances to each input movie
    if isempty(sMap.comp_norm{1})
        %'no norm'
        UserInput = GetUserMovieData(UserInputData(1,:), sData);
        RecMoviesRows = make_predictions1(sMap, sData, UserInput, n, collectionMethod);
        RecMovies = GetMovieNamesFromRows(RecMoviesRows);
    else
        %'norm'
        sDataNorm = som_normalize(sData, sMap.comp_norm{1});
        UserInput = GetUserMovieData(UserInputData(1,:), sDataNorm);
        RecMoviesRows = make_predictions1(sMap, sDataNorm, UserInput, n, collectionMethod);
        RecMovies = GetMovieNamesFromRows(RecMoviesRows);
    end
elseif strcmp(predictionMethod,'sumOfDistances')
    %Sum of distances from each input movie
    if ~isempty(sMap.comp_norm{1})
        error('sMap generated using normalized data. Should be un-normalized data');
        return;
    end
    UserInput = GetUserMovieData(UserInputData(1,:), sData);
    RecMoviesRows = make_predictions2(sMap, sData, UserInput, n, collectionMethod);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
elseif strcmp(predictionMethod,'addandreduceto1')
    %'addandreduceto1'
    if ~isempty(sMap.comp_norm{1})
        error('sMap generated using normalized data. Should be un-normalized data');
        return;
    end
    UserInput = GetUserMovieData(UserInputData(1,:), sData);
    RecMoviesRows = make_predictions3(sMap, sData, UserInput, n, collectionMethod);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
elseif strcmp(predictionMethod, 'cosine')
    %'cosine'
    %This should work on normalized data - fix accordingly. 
    if ~isempty(sMap.comp_norm{1})
        error('sMap generated using normalized data. Should be un-normalized data');
        return;
    end
    UserInput = GetUserMovieData(UserInputData(1,:), sData);
    RecMoviesRows = make_predictions4(sMap, sData, UserInput, n, collectionMethod);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
elseif strcmp(predictionMethod,'add')
    %'add and compare'
    if ~isempty(sMap.comp_norm{1})
        error('sMap generated using normalized data. Should be un-normalized data');
        return;
    end
    UserInput = GetUserMovieData(UserInputData(1,:), sData);
    RecMoviesRows = make_predictions5(sMap, sData, UserInput, n, collectionMethod);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
elseif strcmp(predictionMethod, 'cosineWithoutReduction')
    %'cosine'
    %This should work on normalized data - fix accordingly. 
    if ~isempty(sMap.comp_norm{1})
        error('sMap generated using normalized data. Should be un-normalized data');
        return;
    end
    UserInput = GetUserMovieData(UserInputData(1,:), sData);
    RecMoviesRows = make_predictions6(sMap, sData, UserInput, n, collectionMethod);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
else
    error('predictionMethod did not match anything : %s', predictionMethod);
    return;
end
return;
end