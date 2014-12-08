function [ finalResults ] = batch_test(sM, sD, predictionMethod, inputAmount, outputAmount)
%BATCH_TEST Summary of this function goes here
%   Detailed explanation goes here
load('UserDataFromExcel.mat');
numberOfTestCases = size(UserData, 1);
finalResults = zeros(2,4);
for i = 1:numberOfTestCases
    disp(strcat('User ',num2str(i)));
    [accuracy, recMovies, numberOfInputs] = single_user_test(i, sM, sD, outputAmount, predictionMethod, inputAmount);
    finalResults(i,1) = i;
    finalResults(i,2) = numberOfInputs;
    finalResults(i,3) = size(recMovies,1);
    finalResults(i,4) = accuracy;
end
return;
end

