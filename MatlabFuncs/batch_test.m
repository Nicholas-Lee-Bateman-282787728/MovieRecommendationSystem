function [ finalResults ] = batch_test(sM, sD, inputAmount, outputAmount, predictionMethod, collectionMethod)
%BATCH_TEST Summary of this function goes here
%   Detailed explanation goes here
load('UserDataFromExcel.mat');
numberOfTestCases = size(UserData, 1);
finalResults = zeros(2,4);
totalTP = 0;
totalOutput = 0;
for i = 1:numberOfTestCases
    disp(strcat('User ',num2str(i)));
    [accuracy, recMovies, numberOfInputs, truePositives] = single_user_test(i, sM, sD, outputAmount, inputAmount, predictionMethod, collectionMethod);
    finalResults(i,1) = i;
    finalResults(i,2) = numberOfInputs;
    finalResults(i,3) = size(recMovies,1);
    finalResults(i,4) = accuracy;
    totalTP = totalTP + truePositives;
    totalOutput = totalOutput + size(recMovies,1);
end
microAverage = (totalTP/totalOutput)*100;
finalResults(end+1,1) = microAverage;
return;
end

