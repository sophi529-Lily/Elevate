%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%Match PO in invoice to school%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%use POindex to hold temporary school information
purchaseindex = 0;
POsCharged = [];

%%PULL PURCHASE ORDER OUT OF INVOICES%%

%step through invoices
for xeroindex = 1:InvoiceNum-1
    %if this is a school with PO pull out the PO number
    if contains(Xero.School(xeroindex), "WO")
        purchaseindex = purchaseindex+1;
        AllPOindices(purchaseindex) = xeroindex;
        %identify string indices to pull out number
        POstartIndex = strfind(Xero.School(xeroindex), "WO");
        %pull out PO number
        InvoicePOnum = extractBetween(Xero.School(xeroindex), POstartIndex, POstartIndex+10);
        %add current PO number to list of PO numbers
        POindex(xeroindex) = InvoicePOnum;
    %if this school has no PO pull out the school name    
    else
        POindex(xeroindex) = Xero.To(xeroindex);
    end
end

%%MATCH PO NUMBERS OF INVOICES WITH LIST OF SCHOOL PO NUMBERS%%

%step through invoices with POs
for NumPOinvoices = 1:length(AllPOindices)%(AllPOindices-1)
    
    %pull out position of current PO in original list of invoices
    currentPOpos = AllPOindices(NumPOinvoices);
    
    %pull out current PO
    currentPO = POindex(currentPOpos);
    if (currentPO == "WO191003437")
        currentPO = 'WO190034370';
    end
    
    %boolean matrix of PO match between invoices and school PO
    intermatrix = strcmp(currentPO,allPOinfo);
   
    %If PO is in the tracker
    if ismember(1, intermatrix)
     %pull out location in PO list
     [row,column]= find(intermatrix == 1);
     %pull out school code
     SchoolCode = allPOinfo(row,1);
     %Change the PO array to Schools name
     POindex(currentPOpos) = SchoolCode(1);
    else
        %currentPO
        %error("PO not in tracker");
        continue
    end
    
    % determine total amount of PO charged and populate list -- POs charged
    [numPOsCharged, twocols] = size(POsCharged);
    %if there are no POs charged populate list arbitrarily to begin
    if size(POsCharged) == 0
        POsCharged = ["000", "000"];
    else
        POsCharged = POsCharged;
    end
    
    %check to see if PO is already recorded in our final list - POsCharged
    chargedmatrix = strcmp(currentPO,POsCharged);
    
    %If PO is already recorded in POsCharged
    if ismember(1, chargedmatrix)
        [row,column]= find(chargedmatrix == 1);
        %add new invoice amount to old invoice amount--total amount charged
        %under this PO
        POsCharged(row,2) = str2num(POsCharged(row,2)) + table2array(Xero(AllPOindices(NumPOinvoices),5));
    else
        %PO not already recorded
        %column one is PO number
        POsCharged(numPOsCharged+1,1) = currentPO;
        %column two is amount charged
        POsCharged(numPOsCharged+1,2) = table2array(Xero(AllPOindices(NumPOinvoices),5));
        
    end
end

%MOVE NEWLY FORMATTED DATA INTO XERO SPREADSHEET
Xero(:, 3) = [];
Xero.School(:,1) = POindex(1,:)';