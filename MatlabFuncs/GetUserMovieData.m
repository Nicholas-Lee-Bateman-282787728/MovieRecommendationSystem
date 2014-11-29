function [ MovieMatrix ] = GetUserMovieData( UserMovieIds )
%GETUSERMOVIEDATA Summary of this function goes here
%   Returns a matrix where each row corresponds to the movie that the user
%   likes. Required input is a list of movie ids of the movies the user
%   likes.
load('MovieIDsToRows.mat');
load('MovieData.mat');
UserMovieIds(3,1)
n=length(UserMovieIds);
MovieMatrix = zeros(n,3771);
for i=1:n
    row = find(MovieIDsToRows==UserMovieIds(i,1));
    MovieMatrix(i,:) = MovieData.data(row,:);
end
return;
end

