function [ MovieNameIDs ] = GetMovieNamesFromRows( RowNos )
%GETMOVIENAMESFROMROWS Summary of this function goes here
%   Get a list of movie names and ids from the list of row numbers. Returns
%   a cell array of MovieName and IDs. First column Movie Name and second
%   ID

MovieNameIDs=cell(length(RowNos), 2);
n=length(RowNos);
for i=1:n
    Row = RowNos(i,1);
    [MovieName, MovieID] = RowNumberToMovieName(Row);
    MovieNameIDs(i,:) = [num2cell(MovieID), cellstr(MovieName)];
end
return;
end