function ValispaceMain()
    disp(' ');
    disp('==========================================> VALISPACE ADDON <===========================================');
    disp('Thank you for using Valispace: the best place for your engineering data.');
    disp(' ');
    disp('Example Usage:');
    disp(' ');
    disp('1)  ValispaceInit("https://demo.valispace.com","username","password") % Valispace Login');
    disp('2)  ValispacePull()                                                   % optional: pull all Valis for faster access or access via name');
    disp('3a) ValispaceGetVali("MySat.Mass")                                    % get Vali as a struct');
    disp('3b) ValispaceGetValue("MySat.Mass")                                   % get Value');
    disp('4)  ValispacePushValue("MySat.Mass")                                  % push Value to Valispace');
    disp('5)  ValispaceGetMatrix(217)                                           % get Matrix Values');
    disp('6)  ValispacePushMatrix(217,[2,3;4,5])                                % push Matrix Values');
    disp(' ');
    disp('Please note: Until you run "clear all" the Values be used from your last ValispacePull() call.');
    disp(' ');
    disp('ValispaceGetVali() / ValispaceGetValue() / ValispacePushValue() work with the argument as a string (name) or integer (id)');
    disp('i.e. ValispaceGetValue("MySat.Mass") and ValispaceGetValue(217)');
    disp('When using these functions with an integer id, step 2) can be skipped.');
    disp('In this case the WebInterface will be accessed with every individual call');
    disp(' ');
    disp('Both ValispacePushValue() and ValispacePushMatrix() can also push formulas (e.g. $MySat.Mass*5) instead of values');
    disp(' ');
    disp('For more information please visit http://docs.valispace.com/user-guide/addons/#matlab');
    disp(' ');
        
end