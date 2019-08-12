function infolist = ExtractImportantInfo(filename)

filecontents = extractFileText(filename);


findmarker = strfind(filecontents, 'Where applicable, these instructions to contractors supersede those in PART 1.');
if isempty(findmarker)
    PDFendPrelim = strlength(filecontents);
else
    PDFendPrelim = findmarker;
end
numPDFs = length(PDFendPrelim);

for pag = 1:numPDFs
    
    if pag == 1
        if isempty(findmarker)
            PDFend = PDFendPrelim;
        else
            PDFend = PDFendPrelim(pag)+77;
        end
        PDFbeg = 1;
        
        
    else
        PDFbeg = PDFendPrelim(pag-1)+80;
        PDFend = PDFendPrelim(pag)+77;
        
        
    end
    
       pagerange = extractBetween(filecontents, PDFbeg, PDFend);

    %Extract PO number
    lookforpo = 'WO1900';
    if isempty(strfind(pagerange, lookforpo))
        lookforpo = 'WO1800';
    end
    POnum = strfind(pagerange, lookforpo);
    PObegin = [];
    PObegin = POnum(1);
    POend = [];
    POend = PObegin+10;
    %PONumber = [];
    PONumber = extractBetween(pagerange, PObegin, POend);
  



%Extract total PO amount
dollabillz = strfind(pagerange, '$');
billindic = strfind(pagerange, 'Total Amount');
begintotal = [];
begintotal = dollabillz;
endtotal = [];
endtotal = billindic(1);



%for dfg = 1:length(endtotal)
    %changedbegin = begintotal(find(begintotal == endtotal(dfg)-12))
    changedend = endtotal - 3;
    %strfind(filecontents(changedend - 12:changedend) == '$')
    PrelimPOamount = extractBetween(pagerange, changedend-9, changedend);
    %strfind(PrelimPOamount, '$')
    totalAmount = extractAfter(PrelimPOamount,'$');
    %totalAmount(dfg,1) = extractBetween(filecontents, changedend-9, changedend);
%end


%
%
%
%Extract school name
finddistrict = strfind(pagerange, 'District');
districtbegin = finddistrict(1);
schoolnamebegin = districtbegin + 110;
schoolnameend = schoolnamebegin+3;
%findschoolname = strfind(filecontents, 'HS01');
SchoolName = extractBetween(pagerange, schoolnamebegin, schoolnameend);

infolist(pag,:) = [SchoolName, PONumber, totalAmount];
end
%infolist
end
%clearvars -except filename
