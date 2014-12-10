function [ MovieIDs ] = GetUserMovieIds( UserNo, inputAmount )
%GETUSERMOVIEIDS Summary of this function goes here
% Gets the movie IDs of a user, to be used as input to the prediction system. 
% Amount specifies how many are needed.
load('UserDataFromExcel.mat');
MovieIDs = UserData(UserNo, ~isnan(UserData(UserNo,:)));
if ~isempty(strfind(inputAmount,'%'))
    percent = str2double(strrep(inputAmount,'%',''))/100;
    n = floor(percent*size(MovieIDs,2));
    MovieIDs = MovieIDs(1,1:n);
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

