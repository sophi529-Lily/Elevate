files = dir;

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


allPOinfo = [];
for f = 1:length(files)
    %filename = files(f).name;
    
    allPOinfo = [allPOinfo; test123(files(f).name)];
end
Q5662018 = ["Q566" "WO180092872" "16,050.00"];
Q3262019 = ["Q326" "WO190006255" "17,432.00"];
Q5022019 = ["Q502" "WO190003684" "000"];
K4772018 = ["K477" "WO180065551" "000"];

allPOinfo = [allPOinfo; Q5662018; Q3262019; Q5022019];
%allPOinfo = [allPOinfo; K4772018];

%%
%next steps:
%remove duplicates
%separate by School
%potentially pull out district?
%compare PO total with charged
%integrate with PO tracker obvie
