function [ MovieName ] = RowNumberToMovieName( RowNumber)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load('IDToMovieNameMap.mat');
load('MovieData.mat');
MovieName = IDToMovieMap(str2double(MovieData.labels(RowNumber,2)));
return;
end

