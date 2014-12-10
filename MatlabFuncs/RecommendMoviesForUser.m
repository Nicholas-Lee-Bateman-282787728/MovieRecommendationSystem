function [ RecMovies, RecMoviesRows ] = RecommendMoviesForUser( UserInputData, sMap, sData, n, predictionMethod, collectionMethod )
%GETPREDICTIONSFORUSER Summary of this function goes here
%   Detailed explanation goes here
RecMovies = [];
RecMoviesRows = [];
if strcmp(predictionMethod,'default')
    %'default'
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
elseif strcmp(predictionMethod,'addandreduceto1')
    %'addandreduceto1'
    if ~isempty(sMap.comp_norm{1})
        error('sMap generated using normalized data. Should be un-normalized data');
        return;
    end
    UserInput = GetUserMovieData(UserInputData(1,:), sData);
    RecMoviesRows = make_predictions2(sMap, sData, UserInput, n, collectionMethod);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
elseif strcmp(predictionMethod, 'cosine')
    %'cosine'
    %This should work on normalized data - fix accordingly. 
    if ~isempty(sMap.comp_norm{1})
        error('sMap generated using normalized data. Should be un-normalized data');
        return;
    end
    UserInput = GetUserMovieData(UserInputData(1,:), sData);
    RecMoviesRows = make_predictions3(sMap, sData, UserInput, n, collectionMethod);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);

elseif strcmp(predictionMethod, 'addandnorm')
    %'addandnorm'
    if isempty(sMap.comp_norm{1})
        error('sMap generated using un-normalized data. Should be normalized data');
        return;
    end
    sDataNorm = som_normalize(sData, sMap.comp_norm{1});
    UserInput = GetUserMovieData(UserInputData(1,:), sData);
    %make_predictions9 - breaking this for now
    RecMoviesRows = make_predictions9(sMap, sDataNorm, UserInput, n);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
else
    error('predictionMethod did not match anything : %s', predictionMethod);
    return;
end
return;
end