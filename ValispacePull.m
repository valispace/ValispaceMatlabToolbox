function [ ValiList ] = ValispacePull()
%ValispaceAllValis Returns a list of all Valis and stores it globally
    global ValispaceLogin;
    
    if (length(ValispaceLogin)==0)
        error('You first have to run ValispaceInit()');
    end
    
    options = ValispaceLogin.options;
    url = ValispaceLogin.url + 'vali/';
    global ValiList
    ValiList = rot90(webread(url,options));
end