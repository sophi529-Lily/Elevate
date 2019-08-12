%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%Import information from Xero%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%EDIT IMPORT FORMATTING%%
function [Xero InvoiceNum]= XeroImport(invoicereport)
%Define variable to edit formatting imported information
%name of file changes for each version of PDF
Xopts = detectImportOptions(invoicereport);

%Make variable names more understandable
Xopts.VariableNames{1,2} = 'School';
Xopts.VariableNames{1,9} = 'Cost';

%Set type of importing variables
Xopts = setvartype(Xopts, 'InvoiceNumber', {'string'});
Xopts = setvartype(Xopts, 'To', {'string'});
Xopts = setvartype(Xopts, 'School', {'string'});
Xopts = setvartype(Xopts, 'Cost', {'double'});

%Choose which variables to import
Xopts.SelectedVariableNames = {'InvoiceNumber', 'School', 'To', 'Date', 'Cost'};


%%IMPORT INFORMATION%%

%import
Xero = readtable(invoicereport, Xopts);
%Number of invoices
InvoiceNum = length(Xero.Date);

%Delete extra row
Xero(InvoiceNum,:) = [];
%Extract month from Date
%[xeromonth, xeroyear] = monthyear(Xero.Month);
% Xero.Month = xeromonth;
% Xero.Year = xeroyear;

%clear temporary editing variable
clear Xopts
