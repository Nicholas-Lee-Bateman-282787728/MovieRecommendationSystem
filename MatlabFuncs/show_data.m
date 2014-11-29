function [  ] = show_data( sMap, MovieData, showHits )
%SHOW_DATA Summary of this function goes here
%   Detailed explanation goes here
sMap = som_label(sMap, 'clear', 'all');
sMap = som_autolabel(sMap, MovieData, 'vote');
figure;
som_show(sMap, 'umat', 'all');
figure;
som_show(sMap, 'empty', 'Labels');
som_show_add('label',sMap,'Textsize',10,'TextColor','r','subplot',1);
if strcmp(showHits, 'true')
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
end;
clear;
end

