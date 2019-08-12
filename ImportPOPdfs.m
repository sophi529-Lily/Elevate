
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Import information from PO PDFs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%files in question are the ones in this folder
% clear
% load('allPOinfo.mat')
files = dir;

%this block of code make sure we're only focusing on the PO pdfs
elim = [];
foldr = [];
for i = 1:length(files)
	if files(i).name(1) == '.'
		elim = [elim i];
    elseif (contains(files(i).name, '.pdf') == 0)
        elim = [elim i];
	elseif isdir(strcat(pwd,files(i).name)) == 1
		elim = [elim i];
	elseif files(i).bytes == 0
		elim = [elim i];
	elseif strcmp(files(i).name,'outfile.BbB')
		elim = [elim i];
	end
end
files(elim) = [];

%step through files and pull out PO information
%allPOinfo = [];
for f = 1:length(files)
    
    allPOinfo = [allPOinfo; ExtractImportantInfo(files(f).name, allPOinfo)];
    [height, width] = size(allPOinfo);
    if contains(allPOinfo(height, 1), "000")
        allPOinfo(height, :) = [];
    end
end
clear height
save allPOinfo allPOinfo