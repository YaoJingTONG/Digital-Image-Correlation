%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%    C-scan Image Genration Based on C-scan Amplitude/TOF .txt file      %
%                                                                        %
%                    IMEL@SIUC                                           %
%                                                                        %
%            Anish Poudel July 23 2014                                   %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Clean Up the Memory and Command Window
clear all; close all; clc;

workspace;

%% Import Data from Local File 
[file,Path]=uigetfile('*.txt','Multiselect','ON');

if ischar(file)==1
    file={file};
end

 for i=1:length(file)
    fileToRead1=file{1,i};
    importfile1(fileToRead1);

    % Cut raw data, get rid of title, index/index#, and Scan/scan number
    
    Temp=textdata(3:end,3:128);
    
    % Convert cell data to an Array in double format
    
    for i=1:size(Temp,1)
    for j=1:size(Temp,2)
        if isempty(str2num(cell2mat(Temp(i,j))))==1
            data1(i,j)=NaN;
        else    
            data1(i,j)=str2num(cell2mat(Temp(i,j)));
        end
    end
    end
    
     matrix(:,:)= data1;     % save as a 3D matrix

     end

%% Matrix Cut and setting NaN = 0, prevent raw UT data missing

Cscan = matrix(:,:);    
Cscan(isnan(Cscan))=0;  


%% Saving Image

imwrite(Cscan, [cd '\' 'Load_02', '.tiff']);

%%

figure;
imagesc(Cscan),colormap(jet);
axis([0 127 0 126])
colorbar('EastOutside')
xlabel('Index Axis','FontSize',10)
ylabel('Scan Axis','FontSize',10)
title ('C-Scan Backwall Amplitude','FontWeight','bold','FontSize',10);



