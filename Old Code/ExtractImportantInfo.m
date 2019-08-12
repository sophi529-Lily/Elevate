% function infolist = ExtractImportantInfo(filename)

filecontents = extractFileText(filename);
numPDFs = length(strfind(filecontents, 'Where applicable, these instructions to contractors supersede those in PART 1.'))
PDFend = strfind(filecontents, 'Where applicable, these instructions to contractors supersede those in PART 1.')
for pag = 1:numPDFs
    if pag == 1
        pagerange(pag) = extractBetween(filecontents, 1, PDFend(pag))
    elseif pag == numPDFs
        continue
    else
        pagerange(pag) = extractBetween(filecontents, PDFend(pag), PDFend(pag + 1))
    end
end

%Extract PO number
POnum = strfind(pagerange(1), 'WO1900');
PObegin = [];
PObegin = POnum(:);
POend = [];
POend = PObegin+10;
%PONumber = [];
for asd = 1:length(POend)
    PONumber(asd,1) = extractBetween(filecontents, PObegin(asd), POend(asd));
end
% %%
% %Extract total PO amount
% dollabillz = strfind(filecontents, '$');
% billindic = strfind(filecontents, 'Total Amount');
% begintotal = [];
% begintotal = dollabillz(:);
% endtotal = [];
% endtotal = billindic(:);
% 
% 
% 
% for dfg = 1:length(endtotal)
%     %changedbegin = begintotal(find(begintotal == endtotal(dfg)-12))
%     changedend = endtotal(dfg) - 3
%     %strfind(filecontents(changedend - 12:changedend) == '$')
%     PrelimPOamount = extractBetween(filecontents, changedend-9, changedend);
%     %strfind(PrelimPOamount, '$')
%     totalAmount(dfg,1) = extractAfter(PrelimPOamount,'$')
%     %totalAmount(dfg,1) = extractBetween(filecontents, changedend-9, changedend);
% end
% 
% 
% 
% %Extract school name
% finddistrict = strfind(filecontents, 'District');
% districtbegin = finddistrict(1);
% schoolnamebegin = districtbegin + 110;
% schoolnameend = schoolnamebegin+3;
% findschoolname = strfind(filecontents, 'HS01');
% SchoolName = extractBetween(filecontents, schoolnamebegin, schoolnameend);
% 
% infolist = [SchoolName, PONumber, totalAmount];