function [ sMap, MovieData ] = movie_map( fileName )
%MOVIE_MAP Summary of this function goes here
%   Detailed explanation goes here

MovieData = som_read_data(fileName);
TRAIN1 = som_train_struct('algorithm','seq','phase','rough','data',MovieData);
TRAIN2 = som_train_struct('previous',TRAIN1);
TRAIN0.tracking = '0';
TRAIN0.length_type = 'epochs';
TRAIN0.oder = 'random';
sMap = som_lininit(MovieData);
sMap = som_seqtrain(sMap, MovieData, 'train',TRAIN1,TRAIN0.length_type,TRAIN0.oder);
sMap = som_seqtrain(sMap,MovieData, 'train',TRAIN2,'tracking',1,TRAIN0.length_type, TRAIN0.oder);
figure;
som_show(sMap, 'umat', 'all');
figure;
som_show(sMap, 'empty', 'Labels');
som_show_add('label',sMap,'Textsize',8,'TextColor','r','subplot',1);
figure;
[Pd, V, me, l] = pcaproj(MovieData,2);
Pm = pcaproj(sMap, V, me);
Code = som_colorcode(Pm);
hits = som_hits(sMap, MovieData);
U = som_umat(sMap);
Dm = U(1:2:size(U,1), 1:2:size(U,2));
Dm = 1-Dm(:)/max(Dm(:)); Dm(find(hits==0)) = 0;
subplot(1,2,1);
som_cplane(sMap,Code,Dm);
hold on
Dm = 1-Dm(:)/max(Dm(:)); Dm(find(hits==0)) = 0;
som_grid(sMap,'Label',cellstr(int2str(hits)),...
'Line','none','Marker','none','Labelcolor', 'k');
hold off
title('Color Code with Hits');
clear

end

