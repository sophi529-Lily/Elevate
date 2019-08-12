

%Define editing variable
Trackeropts = detectImportOptions('Purchase Order Tracker (2018-19).xlsx');

% Trackeropts.VariableNamesRange = 'A1';
Trackeropts.DataRange = 'A2';
%select sheet
Trackeropts.Sheet = "PO Follow-Up";
%rename variable names
Trackeropts.VariableNames = genvarname(cellstr(["School" "State" "Contact" "Email" "PurchasingSecretary" "Email" "PORequired" "POGenerated" "WhoOwns" "District" "DOEnum" "POnumber1" "SharepointLink1" "POnumber2" "SharepointLink2" "POnumber3" "Sharepointlink3" "POnumber4" "Sharepointlink4" "POnumber5" "Sharepointlink5" "POnumber6" "Sharepointlink6" "POnumber7" "Sharepointlink7" "POnumber8"]));
%Choose which variables to import
Trackeropts.SelectedVariableNames = {'School', 'POnumber1', 'POnumber2', 'POnumber3', 'POnumber4', 'POnumber5', 'POnumber6', 'POnumber7', 'POnumber8'};
%Extract month from Date
%opts.VariableTypes{1,5} = month(opts.VariableTypes{1,5});

%Import information
PO_Tracker = readtable('Purchase Order Tracker (2018-19).xlsx', Trackeropts);
%Number of schools
SchoolNum = length(PO_Tracker.School);

% %Delete extra 3 rows
PO_Tracker(SchoolNum-2:SchoolNum,:) = [];

clear Trackeropts