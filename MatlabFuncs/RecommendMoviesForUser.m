function [ RecMovies ] = RecommendMoviesForUser( UserNo, UserData, sMap, sData, k, n, predictionMethod )
%GETPREDICTIONSFORUSER Summary of this function goes here
%   Detailed explanation goes here
RecMovies = [];
if strcmp(predictionMethod,'add')
    'add'
    if isempty(sMap.comp_norm{1})
        'no norm'
        UserInput = GetUserMovieData(UserData(UserNo,:), sData);
        UserInputToMP = UserInput(1:ceil(end/2),:);
        UserInput(1,:)
        UserInputToMP(1,:)
        RecMoviesRows = make_predictions1(sMap, sData, UserInputToMP, 5, 40);
        RecMovies = GetMovieNamesFromRows(RecMoviesRows);
    else
        'norm'
        sDataNorm = som_normalize(sData, sMap.comp_norm{1});
        UserInput = GetUserMovieData(UserData(UserNo,:), sDataNorm);
        UserInputToMP = UserInput(1:ceil(end/2),:);
        UserInput(1,:)
        UserInputToMP(1,:)
        RecMoviesRows = make_predictions1(sMap, sDataNorm, UserInputToMP, 5, 40);
        RecMovies = GetMovieNamesFromRows(RecMoviesRows);
    end
elseif strcmp(predictionMethod,'addandreduceto1')
    'addandreduceto1'
    if ~isempty(sMap.comp_norm{1})
        error('sMap generated using normalized data. Should be un-normalized data');
        return;
    end
    UserInput = GetUserMovieData(UserData(UserNo,:), sData);
    UserInputToMP = UserInput(1:ceil(end/2),:);
    UserInput(1,:)
    UserInputToMP(1,:)
    RecMoviesRows = make_predictions2(sMap, sData, UserInputToMP, 5, 40);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
elseif strcmp(predictionMethod, 'addandnorm')
    'addandnorm'
    if isempty(sMap.comp_norm{1})
        error('sMap generated using un-normalized data. Should be normalized data');
        return;
    end
    sDataNorm = som_normalize(sData, sMap.comp_norm{1});
    UserInput = GetUserMovieData(UserData(UserNo,:), sData);
    UserInputToMP = UserInput(1:ceil(end/2),:);
    UserInput(1,:)
    UserInputToMP(1,:)
    RecMoviesRows = make_predictions3(sMap, sDataNorm, UserInputToMP, 5, 40, normMethod);
    RecMovies = GetMovieNamesFromRows(RecMoviesRows);
else
    error('predictionMethod did not match anything : %s', predictionMethod);
    return;
end
return;
end