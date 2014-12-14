function [ accuracy, RecMovies, noOfInputs, truePositives ] = single_user_test(UserNo, sM, sD, n, inputAmount, predictionMethod , collectionMethod)
%SINGLE_USER_TEST Summary of this function goes here
% A little order to the convoluted code - 
% User input data is basically movie IDs
% The movie data is stored as vectors with labels corresponding to the
% movie ID. The row number and the movie ID do not match up. 
% UserInputToSystem and WatchedMovies below are lists of movie IDs. 

load('UserDataFromExcel.mat');
UserInputToSystem = GetUserMovieIds(UserNo, inputAmount);
noOfInputs = size(UserInputToSystem,2);


WatchedMovies = UserData(UserNo,~isnan(UserData(UserNo, :)));
if n==0
    n = size(WatchedMovies, 2) - size(UserInputToSystem,2);
end
[RecMovies, RecMoviesRows] = RecommendMoviesForUser(UserInputToSystem, sM, sD, n, predictionMethod, collectionMethod);

numberOfRecMovies = size(RecMovies,1);
count = 0;
matchingRecMovies = zeros(2,2);
for i=1:numberOfRecMovies
    if(find(WatchedMovies == cell2mat(RecMovies(i,1))))
        count = count + 1;
    else
        matchingRecMovies = RecMovies(i,:);
    end;
end;
accuracy = count/numberOfRecMovies*100;


recall = count*2/size(WatchedMovies,1);
truePositives = count;
return;
end

