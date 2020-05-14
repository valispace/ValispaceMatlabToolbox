function [ ValiList ] = ValispacePull()
%ValispaceAllValis Returns a list of all Valis and stores it globally
    global ValispaceLogin;
    global ValiList;
    global ValiMatrixList;
    
    if (length(ValispaceLogin)==0)
        error('You first have to run ValispaceInit()');
    end
    
    options = ValispaceLogin.options;
    url = strcat(ValispaceLogin.url, 'valis/');
    ValiList = rot90(webread(url,options));
    url2 = strcat(ValispaceLogin.url, 'matrices/');
    ValiMatrixList = rot90(webread(url2,options));
end