function [ accuracy, RecMovies, noOfInputs ] = single_user_test(UserNo, sM, sD, n, predictionMethod , inputAmount)
%SINGLE_USER_TEST Summary of this function goes here
%   Detailed explanation goes here
load('UserDataFromExcel.mat');
UserInput = GetUserMovieIds(UserNo, inputAmount);
noOfInputs = size(UserInput,2);
WatchedMovies = UserData(UserNo,~isnan(UserData(UserNo, :)));
if n==0
    n = size(WatchedMovies, 2) - size(UserInput,2);
end
[RecMovies, RecMoviesRows] = RecommendMoviesForUser(UserInput, sM, sD, n, predictionMethod);

numberOfMovies = size(RecMovies,1);
count = 0;
matchingRecommendedMovies = zeros(2,2);
for i=1:numberOfMovies
    if(find(WatchedMovies == cell2mat(RecMovies(i,1))))
        count = count + 1;
    else
        matchingRecommendedMovies = RecMovies(i,:);
    end;
end;
accuracy = count/numberOfMovies*100;
% recall = count*2/size(WatchedMovies,1); 
end

