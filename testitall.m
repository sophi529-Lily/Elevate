dontmessabout = ["0","0", "0", "0"];
maybeitsok = ["0","0", "0"];
POstostudy = ["0", "0", "0"];
ClosedPOnum = ["0"];
ClosedMatrixIndex = find(Agree(:,2) == "Yes");
% ClosedMatrixIndex = contains(Agree(:,2),'Yes');
% [row,column]= find(ClosedMatrixIndex == 1);
%pull out school code
ClosedPOnum = Agree(ClosedMatrixIndex,1);
     %Change the PO array to Schools name
howlong = 0;
    toolong = 0;
     

for xeroint = 1:height(Xero)
    
    if not(contains(Xero.Status(xeroint),"Paid"))
        if contains(Xero.School(xeroint), "WO")
            InvoiceNumberstudying = num2str(Xero.InvoiceNumber(xeroint));
            CostNumberStudying = num2str(Xero.Cost(xeroint));
            PONumberstudying = Xero.School(xeroint);
            [polookingat, nah] = size(POstostudy);
            POstostudy(polookingat +1,:) = [InvoiceNumberstudying,PONumberstudying, CostNumberStudying];
        end
    end
end

for polocation = 1:polookingat+1
    [howlong, nope] = size(dontmessabout);
    [toolong, hark] = size(maybeitsok);    
            MatchThePO = POstostudy(polocation,2);
            if contains(MatchThePO, "WO1900")
                MatchThePO = replace(MatchThePO, "WO1900", "201930");
            elseif contains(MatchThePO, "WO2000")
                MatchThePO = replace(MatchThePO, "WO2000", "202030");
            elseif contains(MatchThePO, "WO1800")
                MatchThePO = replace(MatchThePO, "WO1800", "201830");
           
            end
            findthepo = find(MatchThePO == ClosedPOnum);
            if not(isempty(findthepo))
                    %PONumberstudying = Xero.School(polocation)
                    dontmessabout(howlong+1,1:3) = POstostudy(polocation,:);
                    dontmessabout(howlong+1, 
                    dontmessabout(howlong+1,4) = MatchThePO;
%                     dontmessabout(howlong+1,2) = Xero.School(xeroint);
%                     dontmessabout(howlong+1,3) = Xero.Cost(xeroint);
%                     dontmessabout(howlong+1,4) = PONumberstudying;
%                     dontmessabout(howlong+1,5) = ClosedPOnum(findthepo);
                    
            else
                maybeitsok(toolong+1,:) = POstostudy(polocation,:);
%                 maybeitsok(toolong+1,2) = Xero.School(xeroint);
%                 maybeitsok(toolong+1,3) = Xero.Cost(xeroint);
%                 maybeitsok(toolong+1,4) = PONumberstudying;
                
            end
end

amountToLose = sum(str2double(dontmessabout(:,3)));

filenameClosed = 'ClosedInvoices.xlsx';
writematrix(dontmessabout,filenameClosed);

filenameOpen = 'OpenInvoices.xlsx';
writematrix(maybeitsok,filenameOpen);