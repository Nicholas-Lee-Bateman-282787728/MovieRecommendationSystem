function [ MovieIDs ] = GetUserMovieIds( UserNo, inputAmount )
%GETUSERMOVIEIDS Summary of this function goes here
% Gets the movie IDs of the user. Amount specifies how many are needed
load('UserDataFromExcel.mat');
MovieIDs = UserData(UserNo, ~isnan(UserData(UserNo,:)));
if strcmp(inputAmount,'half')
    MovieIDs = MovieIDs(1,1:ceil(end/2));
else
    n = str2double(inputAmount);
    if (size(MovieIDs,2) > n)
        MovieIDs = MovieIDs(1,1:n);
    else
        error('Amount is greater than movie size');
    end
end
return;
end

