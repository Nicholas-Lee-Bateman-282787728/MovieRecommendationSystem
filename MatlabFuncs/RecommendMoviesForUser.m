function [ RecMovies, RecMoviesRows ] = RecommendMoviesForUser( UserData, sMap, sData, n, predictionMethod )
%GETPREDICTIONSFORUSER Summary of this function goes here
%   Detailed explanation goes here
RecMovies = [];
RecMoviesRows = [];
if strcmp(predictionMethod,'default')
    %'default'
    if isempty(sMap.comp_norm{1})
        %'no norm'
        UserInput = GetUserMovieData(UserData(1,:), sData);
        RecMoviesRows = make_predictions1(sMap, sData, UserInput, n);
        RecMovies = GetMovieNamesFromRows(RecMoviesRows);
    else
        %'norm'
        sDataNorm = som_normalize(sData, sMap.comp_norm{1});
        UserInput = GetUserMovieData(UserData(1,:), sDataNorm);
        RecMoviesRows = make_predictions1(sMap, sDataNorm, UserInput, n);
        RecMovies = GetMovieNamesFromRows(RecMoviesRows);
    end
elseif strcmp(predictionMethod,'addandreduceto1')
    %'addandreduceto1'
    if ~isempty(sMap.comp_norm{1})
        error('sMap generated using normalized data. Should be un-normalized data');
        return;
    end
    UserInput = GetUserMovieData(UserData(1,:), sData);
    RecMoviesRows = make_predictions2(sMap, sData, UserInput, n);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
elseif strcmp(predictionMethod, 'addandnorm')
    %'addandnorm'
    if isempty(sMap.comp_norm{1})
        error('sMap generated using un-normalized data. Should be normalized data');
        return;
    end
    sDataNorm = som_normalize(sData, sMap.comp_norm{1});
    UserInput = GetUserMovieData(UserData(1,:), sData);
    RecMoviesRows = make_predictions3(sMap, sDataNorm, UserInput, n);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
else
    error('predictionMethod did not match anything : %s', predictionMethod);
    return;
end
return;
end