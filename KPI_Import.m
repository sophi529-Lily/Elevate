%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Import information from US Macro KPI%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%EDIT IMPORT FORMATTING%%

%Define variable to edit formatting imported information
SeminarOpts = spreadsheetImportOptions("NumVariables", 25);

%choose sheet to import from
SeminarOpts.Sheet = "Sem Master";
%rename variable names
SeminarOpts.VariableNames = genvarname(cellstr(["Var1" "Var2" "Var3" "Var4" "Date" "School" "Var7" "Var8" "Var9" "Var10" "Var11" "Var12" "Seminar" "Var14" "Var15" "Var16" "Var17" "Var18" "Var19" "Cost"]));
%Choose which variables to import
SeminarOpts.SelectedVariableNames = {'Date', 'School', 'Seminar', 'Cost'};
SeminarOpts = setvartype(SeminarOpts, 'School', {'string'});
SeminarOpts = setvartype(SeminarOpts, 'Seminar', {'string'});

%%IMPORT INFORMATION%%

%Import information
Seminars = readtable('US Macro KPI Report.xlsx', SeminarOpts);

% Delete top row with variable names
Seminars(1,:) = [];

%Extract month from Date
% [monthy, yearly] = monthyear(Seminars.Month);
% Seminars.Month = monthy;
% Seminars.Year = yearly;

%clear temporary editing variable
clear SeminarOpts