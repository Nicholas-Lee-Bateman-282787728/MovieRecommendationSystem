function [sMap, MovieData] = movie_map( fileName, normMethod )
%MOVIE_MAP Summary of this function goes here
%   Detailed explanation goes here

MovieData = som_read_data(fileName);
if strcmp(normMethod,'none')
    TRAIN1 = som_train_struct('algorithm','seq','phase','rough','data',MovieData);
    TRAIN2 = som_train_struct('previous',TRAIN1);
    TRAIN0.tracking = '0';
    TRAIN0.length_type = 'epochs';
    TRAIN0.oder = 'random';
    sMap = som_lininit(MovieData);
    sMap = som_seqtrain(sMap, MovieData, 'train',TRAIN1,TRAIN0.length_type,TRAIN0.oder);
    sMap = som_seqtrain(sMap,MovieData, 'train',TRAIN2,'tracking',1,TRAIN0.length_type, TRAIN0.oder);
    sMap = som_autolabel(sMap, MovieData, 'vote');
else
    MovieDataNorm = som_normalize(MovieData, normMethod);
    TRAIN1 = som_train_struct('algorithm','seq','phase','rough','data',MovieDataNorm);
    TRAIN2 = som_train_struct('previous',TRAIN1);
    TRAIN0.tracking = '0';
    TRAIN0.length_type = 'epochs';
    TRAIN0.oder = 'random';
    sMap = som_lininit(MovieDataNorm);
    sMap = som_seqtrain(sMap, MovieDataNorm, 'train',TRAIN1,TRAIN0.length_type,TRAIN0.oder);
    sMap = som_seqtrain(sMap,MovieDataNorm, 'train',TRAIN2,'tracking',1,TRAIN0.length_type, TRAIN0.oder);
    sMap = som_autolabel(sMap, MovieDataNorm, 'vote');
    MovieData = MovieDataNorm;
end
return;
end