%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compare total amount of PO against total amount charged against PO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for purchaseme = 1:length(POsCharged)
    POstudied = POsCharged(purchaseme,1);
    POmatrix = strcmp(POstudied,allPOinfo);
    
    %If PO is already recorded
    if ismember(1, POmatrix)
        [row,column]= find(POmatrix == 1);
        %add the amount charged to the PO info spreadsheet
        allPOinfo(row,4) = POsCharged(purchaseme,2);
        %find difference between total PO amount and amount charged
        allPOinfo(row,5) = str2double(allPOinfo(row,4)) - str2double(allPOinfo(row,3));
    else
        %put PO into spreadsheet--I dont have that PO on file
        allPOinfo(length(allPOinfo)+1,2) =  POsCharged(purchaseme,1);
        allPOinfo(length(allPOinfo)+1,4) =  POsCharged(purchaseme,2);
        %mark down POs charged without being on my list
        allPOinfo(length(allPOinfo)+1,5) =  -1*str2double(POsCharged(purchaseme,2));
    end
end

filename = 'POsCharged.xlsx';
POtitleArray = ["School" "PO Number" "Total Amount" "Amount Charged" "Difference"];
allPOinfo = [POtitleArray; allPOinfo];
writematrix(allPOinfo,filename);