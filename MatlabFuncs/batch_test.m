function [ finalResults ] = batch_test(sM, sD, k, predictionMethod, amount)
%BATCH_TEST Summary of this function goes here
%   Detailed explanation goes here
load('UserDataFromExcel.mat');
numberOfTestCases = size(UserData, 1);

finalResults = zeros(2,2);
for i = 1:numberOfTestCases
    [accuracy, recMovies] = single_user_test(i, sM, sD, k, 0, predictionMethod, amount);
    finalResults(i,1) = i;
    finalResults(i,2) = accuracy;
end
finalResults
return;
end

