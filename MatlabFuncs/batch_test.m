function [ finalResults ] = batch_test(sM, sD, k, predictionMethod, amount)
%BATCH_TEST Summary of this function goes here
%   Detailed explanation goes here
load('UserDataFromExcel.mat');
numberOfTestCases = size(UserData, 1);
finalResults = zeros(2,4);
for i = 1:numberOfTestCases
    [accuracy, recMovies, numberOfInputs] = single_user_test(i, sM, sD, k, 0, predictionMethod, amount);
    finalResults(i,1) = i;
    finalResults(i,2) = accuracy;
    finalResults(i,3) = numberOfInputs;
    finalResults(i,4) = size(recMovies,1);
end
return;
end

