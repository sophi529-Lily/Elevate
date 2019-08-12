clear
%this information will change each time
thismonthis = "July";
thisyearis = 2019;
Xerodownload = 'Elevate Education Inc - Customer Invoice Report (United States Dollar)[317]';

%load previous PO information
load('allPOinfo.mat')
%importPOPdfs
ImportPOPdfs
%import information from Xero
Xero = XeroImport(Xerodownload);
InvoiceNum = height(Xero);
%import information from Portal
KPI_Import
%setup information from Xero
XeroSetup
%setup information from Portal
KPIsetup
%compare Portal and Xero information
AnalyzeMonth(thismonthis, thisyearis, Xero, Seminars)
%analyze PO information
understandPOs
%clear up the workspace
clearvars -except Xero Seminars allPOinfo FinalCompare POsCharged

