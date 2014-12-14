function [ FinalResults ] = runalltests( mapSize )
%RUNALLTESTS Summary of this function goes here
%   Detailed explanation goes here
load('MovieData.mat');
if strcmp(mapSize, 'big')
    load('BigMovieMap.mat');
    finalResultsminimumdistance1 = batch_test(BigMovieMap, MovieData, '50%', 0, 'minimumdistance', 'individual');
    finalResultsminimumdistance2 = batch_test(BigMovieMap, MovieData, '50%', 0, 'minimumdistance', 'combined');
    finalResultsminimumdistance3 = batch_test(BigMovieMap, MovieData, '50%', 0, 'minimumdistance', 'combinedto1');
    
    finalResultssumdistance1 = batch_test(BigMovieMap, MovieData, '50%', 0, 'sumdistances', 'individual');
    finalResultssumdistance2 = batch_test(BigMovieMap, MovieData, '50%', 0, 'sumdistances', 'combined');
    finalResultssumdistance3 = batch_test(BigMovieMap, MovieData, '50%', 0, 'sumdistances', 'combinedto1');
    
    finalResultsaddandreduceto11 = batch_test(BigMovieMap, MovieData, '50%', 0, 'addandreduceto1', 'individual');
    finalResultsaddandreduceto12 = batch_test(BigMovieMap, MovieData, '50%', 0, 'addandreduceto1', 'combined');
    finalResultsaddandreduceto13 = batch_test(BigMovieMap, MovieData, '50%', 0, 'addandreduceto1', 'combinedto1');
    
    finalResultscosinereduceto11 = batch_test(BigMovieMap, MovieData, '50%', 0, 'cosinereduceto1', 'individual');
    finalResultscosinereduceto12 = batch_test(BigMovieMap, MovieData, '50%', 0, 'cosinereduceto1', 'combined');
    finalResultscosinereduceto13 = batch_test(BigMovieMap, MovieData, '50%', 0, 'cosinereduceto1', 'combinedto1');
    
    finalResultsadd1 = batch_test(BigMovieMap, MovieData, '50%', 0, 'add', 'individual');
    finalResultsadd2 = batch_test(BigMovieMap, MovieData, '50%', 0, 'add', 'combined');
    finalResultsadd3 = batch_test(BigMovieMap, MovieData, '50%', 0, 'add', 'combinedto1');
    
    finalResultscosinecombined1 = batch_test(BigMovieMap, MovieData, '50%', 0, 'cosinecombined', 'individual');
    finalResultscosinecombined2 = batch_test(BigMovieMap, MovieData, '50%', 0, 'cosinecombined', 'combined');
    finalResultscosinecombined3 = batch_test(BigMovieMap, MovieData, '50%', 0, 'cosinecombined', 'combinedto1');
    
    finalResultsdotproductcombined1 = batch_test(BigMovieMap, MovieData, '50%', 0, 'dotproductcombined', 'individual');
    finalResultsdotproductcombined2 = batch_test(BigMovieMap, MovieData, '50%', 0, 'dotproductcombined', 'combined');
    finalResultsdotproductcombined3 = batch_test(BigMovieMap, MovieData, '50%', 0, 'dotproductcombined', 'combinedto1');
    
    finalResultsdotproductreducedto11 = batch_test(BigMovieMap, MovieData, '50%', 0, 'dotproductreduceto1', 'individual');
    finalResultsdotproductreducedto12 = batch_test(BigMovieMap, MovieData, '50%', 0, 'dotproductreduceto1', 'combined');
    finalResultsdotproductreducedto13 = batch_test(BigMovieMap, MovieData, '50%', 0, 'dotproductreduceto1', 'combinedto1');
    
    finalResultsdotproduct = batch_test(BigMovieMap, MovieData, '50%', 0, 'dotproduct', 'individual');
    finalResultsdotproduct = batch_test(BigMovieMap, MovieData, '50%', 0, 'dotproduct', 'combined');
    finalResultsdotproduct = batch_test(BigMovieMap, MovieData, '50%', 0, 'dotproduct', 'combinedto1');
    save('CS394n/Project/MovieRecommendationSystem/MatlabFuncs/Results/BigMapResults.mat');
else
    load('MovieMap.mat');
    finalResultsminimumdistance1 = batch_test(MovieMap, MovieData, '50%', 0, 'minimumdistance', 'individual');
    finalResultsminimumdistance2 = batch_test(MovieMap, MovieData, '50%', 0, 'minimumdistance', 'combined');
    finalResultsminimumdistance3 = batch_test(MovieMap, MovieData, '50%', 0, 'minimumdistance', 'combinedto1');
    
    finalResultssumdistance1 = batch_test(MovieMap, MovieData, '50%', 0, 'sumdistances', 'individual');
    finalResultssumdistance2 = batch_test(MovieMap, MovieData, '50%', 0, 'sumdistances', 'combined');
    finalResultssumdistance3 = batch_test(MovieMap, MovieData, '50%', 0, 'sumdistances', 'combinedto1');
    
    finalResultsaddandreduceto11 = batch_test(MovieMap, MovieData, '50%', 0, 'addandreduceto1', 'individual');
    finalResultsaddandreduceto12 = batch_test(MovieMap, MovieData, '50%', 0, 'addandreduceto1', 'combined');
    finalResultsaddandreduceto13 = batch_test(MovieMap, MovieData, '50%', 0, 'addandreduceto1', 'combinedto1');
    
    finalResultscosinereduceto11 = batch_test(MovieMap, MovieData, '50%', 0, 'cosinereduceto1', 'individual');
    finalResultscosinereduceto12 = batch_test(MovieMap, MovieData, '50%', 0, 'cosinereduceto1', 'combined');
    finalResultscosinereduceto13 = batch_test(MovieMap, MovieData, '50%', 0, 'cosinereduceto1', 'combinedto1');
    
    finalResultsadd1 = batch_test(MovieMap, MovieData, '50%', 0, 'add', 'individual');
    finalResultsadd2 = batch_test(MovieMap, MovieData, '50%', 0, 'add', 'combined');
    finalResultsadd3 = batch_test(MovieMap, MovieData, '50%', 0, 'add', 'combinedto1');
    
    finalResultscosinecombined1 = batch_test(MovieMap, MovieData, '50%', 0, 'cosinecombined', 'individual');
    finalResultscosinecombined2 = batch_test(MovieMap, MovieData, '50%', 0, 'cosinecombined', 'combined');
    finalResultscosinecombined3 = batch_test(MovieMap, MovieData, '50%', 0, 'cosinecombined', 'combinedto1');
    
    finalResultsdotproductcombined1 = batch_test(MovieMap, MovieData, '50%', 0, 'dotproductcombined', 'individual');
    finalResultsdotproductcombined2 = batch_test(MovieMap, MovieData, '50%', 0, 'dotproductcombined', 'combined');
    finalResultsdotproductcombined3 = batch_test(MovieMap, MovieData, '50%', 0, 'dotproductcombined', 'combinedto1');
    
    finalResultsdotproductreducedto11 = batch_test(MovieMap, MovieData, '50%', 0, 'dotproductreduceto1', 'individual');
    finalResultsdotproductreducedto12 = batch_test(MovieMap, MovieData, '50%', 0, 'dotproductreduceto1', 'combined');
    finalResultsdotproductreducedto13 = batch_test(MovieMap, MovieData, '50%', 0, 'dotproductreduceto1', 'combinedto1');
    
    finalResultsdotproduct = batch_test(MovieMap, MovieData, '50%', 0, 'dotproduct', 'individual');
    finalResultsdotproduct = batch_test(MovieMap, MovieData, '50%', 0, 'dotproduct', 'combined');
    finalResultsdotproduct = batch_test(MovieMap, MovieData, '50%', 0, 'dotproduct', 'combinedto1');
    save('CS394n/Project/MovieRecommendationSystem/MatlabFuncs/Results/SmallMapResults.mat');
end
end

