function [ MovieNameIDs ] = GetMovieNamesFromRows( RowNos )
%   Get a list of movie names and ids from the list of row numbers. Returns
%   a cell array of MovieName and IDs. First column Movie Name and second
%   ID

MovieNameIDs=cell(size(RowNos,1), 2);
n=size(RowNos,1);
for i=1:n
    Row = RowNos(i,1);
    [MovieName, MovieID] = RowNumberToMovieName(Row);
    MovieNameIDs(i,:) = [num2cell(MovieID), cellstr(MovieName)];
end
return;
end