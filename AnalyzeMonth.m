function A = AnalyzeMonth(currentmonth, currentyear, Xero, Seminars)

MonthNames = ["January" "February" "March" "April" "May" "June" "July" "August" "September" "October" "November" "December"];
filename = 'OutputDoc.xlsx';

%currentmonth = "July";
currentmonthnumber = find(strcmp(currentmonth, MonthNames));
% select month you want to focus on
for i = 1:length(MonthNames)%currentmonthnumber 
    
    %%FIND SEMINARS AND XERO IN JUST THAT MONTH%%
    
    %ID location of seminars in KPI and Xero
%     thisMonthSeminarIndex = find([currentmonthnumber, currentyear] == monthyear(Seminars.Date));
%     thisMonthXeroIndex = find([currentmonthnumber, currentyear] == monthyear(Xero.Date));
    
    %reference date
    firsttry = [currentmonthnumber, currentyear];
    %actual dates
    [let, me] = monthyear(Seminars.Date);
    [jog, faster] = monthyear(Xero.Date);
    lasttrySeminars = [let me];
    lasttryXero = [jog faster];

    %month match
    monthyseminars = find(firsttry(:,1) == lasttrySeminars(:,1));
    monthyxero = find(firsttry(:,1) == lasttryXero(:,1));
    %year match
    yearlyxero = find(firsttry(:,2) == lasttryXero(:,2));
    yearlyseminars = find(firsttry(:,2) == lasttrySeminars(:,2));
    %both match - dyearlyseminars = find(firsttry(:,2) == lasttrySeminars(:,2));ate index
    thisMonthSeminarIndex = intersect(monthyseminars, yearlyseminars, 'rows');
    thisMonthXeroIndex = intersect(monthyxero, yearlyxero, 'rows');

    %ID seminars in KPI
    thisMonthSeminars(:,1) = Seminars.School(thisMonthSeminarIndex);
    thisMonthSeminars(:,2) = Seminars.Cost(thisMonthSeminarIndex);
    
    %ID seminars in Xero
    thisMonthXero(:,1) = Xero.School(thisMonthXeroIndex);
    thisMonthXero(:,2) = Xero.Cost(thisMonthXeroIndex);
    
    %save Xero seminar cost as independent variable
    XeroSeminarCost = thisMonthXero(:,2);
    
    %number of seminars in the KPI report this month
    monthseminarlength = length(thisMonthSeminars(:,1));
    %number of seminars in Xero this month
    monthxerolength = length(thisMonthXero(:,1));
    
    indexpermonth = 1;
    
    %%STEP THROUGH KPI SEMINARS THIS MONTH%%
    %compare with Xero seminars
    for movethroughmonth = 1:monthseminarlength
        %current school
        currentschool = thisMonthSeminars(movethroughmonth,1);
        
        %if there's a 0 there we already recorded the school - move on
        if str2double(currentschool) == 0
            %movethroughmonth = movethroughmonth +1;
            continue
        else
            %find this school in the list of seminars
            %will likely return an array and not a single value
            %we probably came multiple times
            FindInSchool = find(currentschool == thisMonthSeminars(:,1));
            %find this school in list of invoices
            %will likely return an array and not a single value
            %we probably charged multiple times
            FindInXero = find(currentschool == thisMonthXero(:,1));
            %sum school cost on KPI
            SchoolCostSum = sum(str2double(thisMonthSeminars(FindInSchool,2)));
            %sum school cost on Xero
            XeroCostSum = sum(str2double(XeroSeminarCost(FindInXero)));
        end
        
        
        %erase multiples from KPI list
        thisMonthSeminars(FindInSchool,:) = 0;
        %erase multiples from Xero list
        thisMonthXero(FindInXero,:) = 0;
        
        %RECORD SCHOOL INFORMATION IN ARRAY%
        
        %cell array of school, KPI cost, Xero cost, and difference
        FinalCompare{1,i}(indexpermonth,1) = currentschool;
        FinalCompare{1,i}(indexpermonth,2) = SchoolCostSum;
        FinalCompare{1,i}(indexpermonth,3) = XeroCostSum;
        FinalCompare{1,i}(indexpermonth,4) = XeroCostSum - SchoolCostSum;
        FinalCompare{1,i}(indexpermonth,5) = (XeroCostSum - SchoolCostSum)/...
            SchoolCostSum;
        indexpermonth = indexpermonth +1;
        
    end
    
    %get rid of 0s in Xero list- inserted as placeholders in seminars dealt with
    thisMonthXero(strcmp(thisMonthXero(:, 1), '0'), :) = [];
    
    %%STEP THROUGH XERO SEMINARS THIS MONTH%%
    %%any found on KPI have been recorded. This isolates those not on KPI%% 
    
    %insertintofinal = indexpermonth-1;
    insertintofinal = indexpermonth;
    for x = 1:length(thisMonthXero(:,1))
        
        currentinvoice = thisMonthXero(x,1);
        
        %if current invoice is a 0 that means it's been dealt with-skip
        if str2double(currentinvoice) == 0
            continue
        %otherwise, sum all times school was charged
        else
            FindXeroDiff = find(currentinvoice == thisMonthXero(:,1));
            FindXeroDiffSum = sum(str2double(thisMonthXero(FindXeroDiff, 2)));
        end
        %mark invoice dealt with as 0
        thisMonthXero(FindXeroDiff, :) = 0;
        
        %RECORD SCHOOL INFORMATION IN ARRAY%
        %add onto previously created array
        FinalCompare{1,i}(insertintofinal,1) = currentinvoice;
        FinalCompare{1,i}(insertintofinal,2) = 0;
        FinalCompare{1,i}(insertintofinal,3) = FindXeroDiffSum;
        FinalCompare{1,i}(insertintofinal,4) = FindXeroDiffSum;
        FinalCompare{1,i}(insertintofinal,5) = 1;
        insertintofinal = insertintofinal + 1;
    end
    
    clear thisMonthSeminars
    clear thisMonthXero
    
    %uncomment line below if recording information from multiple months
    % sheet = strcat('Sheet', 'f%', month);
    
    %make an array of the final information to export
    A = FinalCompare{1,i}(:,:);
    toprowlabels = ["School Name" "Portal Amount" "Xero Amount" "Difference" "Percent difference"];
    A = [toprowlabels; A];
    %export final information
    writematrix(A,filename,'Sheet', currentmonth);
    
end
