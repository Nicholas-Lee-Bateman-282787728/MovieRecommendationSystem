function [ MovieName ] = RowNumberToMovieName( RowNumber, Labels)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
load('IDToMovieNameMap.mat');
MovieName = IDToMovieMap(str2double(Labels(RowNumber,2)));
return;
end

