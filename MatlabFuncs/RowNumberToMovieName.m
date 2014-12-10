function [ MovieName, MovieID ] = RowNumberToMovieName( RowNumber)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% This is really clunky - the MovieIDsToRows table already has this
% information. 
load('IDToMovieNameMap.mat');
load('MovieData.mat');
MovieName = IDToMovieNameMap(str2double(MovieData.labels(RowNumber,2)));
MovieID = str2double(MovieData.labels(RowNumber,2));
return;
end

