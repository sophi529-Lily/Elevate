%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%Pull out school code from KPI%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Determine number of seminars
SeminarNum = length(Seminars.School);

StrA = " ";
StrB = "-";
StrC = "MS";
StrD = "IS";


for indexsemnum = 1:SeminarNum
    %if the school only has a code dont rename it
    if strlength(Seminars.School(indexsemnum)) == 4
        schoolCode = extractBetween(Seminars.School(indexsemnum), 1,4);
    %if school has a code rename to just the code
    elseif strcmp(extractBetween(Seminars.School(indexsemnum), 5,5), StrA) || strcmp(extractBetween(Seminars.School(indexsemnum), 5,5), StrB)
        schoolCode = extractBetween(Seminars.School(indexsemnum), 1,4);
        %if school has no code dont rename -- private/nj school
    else
        schoolCode = Seminars.School(indexsemnum);
    end
    %replace original school names with new ones 
    Seminars.School(indexsemnum) = schoolCode;
end
    
