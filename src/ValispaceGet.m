function [ out_data ] = ValispaceGet(url)
% Custom GET request to the Valispace REST API
    global ValispaceLogin
    
    if (length(ValispaceLogin) == 0)
        error('You first have to run ValispaceInit()');
    end

    if isempty(strfind(url, 'http') ~= 1)
        url = strcat(ValispaceLogin.url, url);
    end

    out_data = webread(url, ValispaceLogin.options);
end
