function [ MovieMatrix ] = GetUserMovieData( UserMovieIds )
%GETUSERMOVIEDATA Summary of this function goes here
%   Returns a matrix where each row corresponds to the movie that the user
%   likes. Required input is a list of movie ids of the movies the user
%   likes.
load('MovieIDsToRows.mat');
load('MovieData.mat');
a=find(isnan(UserMovieIds(1,:))==1);
n=a(1)-1;
MovieMatrix = zeros(n,size(MovieData.data,2));
count = 1;
emptyCount = 0;
for i=1:n
    row = find(MovieIDsToRows==UserMovieIds(1,i));
    UserMovieIds(1,i)
    row
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

