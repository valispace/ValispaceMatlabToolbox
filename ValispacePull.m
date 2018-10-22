function [ ValiList ] = ValispacePull()
%ValispaceAllValis Returns a list of all Valis and stores it globally
    global ValispaceLogin;
    global ValiList;
    
    if (length(ValispaceLogin)==0)
        error('You first have to run ValispaceInit()');
    end
    
    options = ValispaceLogin.options;
    url = strcat(ValispaceLogin.url, 'vali/');
    ValiList = rot90(webread(url,options));
end