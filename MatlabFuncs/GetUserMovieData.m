function [ MovieMatrix ] = GetUserMovieData( UserMovieIds )
%GETUSERMOVIEDATA Summary of this function goes here
%   Returns a matrix where each row corresponds to the movie that the user
%   likes. Required input is a list of movie ids of the movies the user
%   likes.
load('MovieIDsToRows.mat');
load('MovieData.mat');
n=length(UserMovieIds);
MovieMatrix = zeros(n,3771);
count = 1;
emptyCount = 0;
for i=1:n
    row = find(MovieIDsToRows==UserMovieIds(i,1));
    if(~isempty(row))
        MovieMatrix(count,:) = MovieData.data(row,:);
        count = count + 1;
    else
        emptyCount = emptyCount + 1;
    end;
end
MovieMatrix = MovieMatrix(1:n-emptyCount,:);
return;
end

