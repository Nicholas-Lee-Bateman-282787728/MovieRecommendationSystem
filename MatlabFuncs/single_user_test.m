function [ accuracy, RecMovies ] = single_user_test(UserNo, sM, sD, k, n, predictionMethod )
%SINGLE_USER_TEST Summary of this function goes here
%   Detailed explanation goes here
load('UserDataFromExcel.mat');

[RecMovies, RecMoviesRows] = RecommendMoviesForUser(UserNo, UserData, sM, sD, k, n, predictionMethod);
WatchedMovies = UserData(UserNo,~isnan(UserData(UserNo, :)));

numberOfMovies = length(RecMovies);
count = 0;
RecMovies
recommendedMovies = zeros(2,2); 
for i=1:numberOfMovies
    if(find(WatchedMovies == cell2mat(RecMovies(i,1))))
        count = count + 1;
    else
        recommendedMovies = RecMovies(i,:);
    end;
    
end;

accuracy = count/numberOfMovies*100;

end

