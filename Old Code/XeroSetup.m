
%Match PO to Xero Reference

%%use POindex to hold temporary school information
purchaseindex = 0;
for xeroindex = 1:InvoiceNum-1
    %if this is a school with PO pull out the PO
    if contains(Xero.School(xeroindex), "WO")
        purchaseindex = purchaseindex+1;
        AllPOindices(purchaseindex) = xeroindex;
        POstartIndex = strfind(Xero.School(xeroindex), "WO");
        InvoicePOnum = extractBetween(Xero.School(xeroindex), POstartIndex, POstartIndex+10);
        POindex(xeroindex) = InvoicePOnum;
    %if this school has no PO pull out the school name    
    else
        POindex(xeroindex) = Xero.To(xeroindex);
    end
end

for NumPOinvoices = 1:length(AllPOindices-1)
    %pull out position of current PO
    currentPOpos = AllPOindices(NumPOinvoices);
    %pull out current PO
    currentPO = POindex(currentPOpos);
    if (currentPO == "WO191003437")
        currentPO = 'WO190034370';
    end
    %boolean matrix of PO match
    %intermatrix = strcmp(currentPO,PO_Tracker);
    intermatrix = strcmp(currentPO,allPOinfo);
    %If PO is in the tracker
    if ismember(1, intermatrix)
     %pull out location in tracker
     [row,column]= find(intermatrix == 1);
     SchoolCode = extractBetween(table2array(PO_Tracker(row,1)), 1, 4);
     %Change the PO array to Schoosl name
     POindex(currentPOpos) = SchoolCode;
    else
        currentPO
        error("PO not in tracker");
    end
   
    
end
%move newly formatted data into Xero Spreadsheet
Xero(:, 3) = [];
Xero.School(:,1) = POindex(1,:);

    
%%
%
%
%Match names and prices
%print out differences --
    %List seminars
    %Price Breakdown
    %total lost
    %any reasoning
    %one sheet per month? 