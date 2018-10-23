function [ data ] = ValispaceGet(url)
% Custom GET request to the Valispace REST API
    global ValispaceLogin
    
    if (length(ValispaceLogin) == 0)
        error('You first have to run ValispaceInit()');
    end

    url = strcat(ValispaceLogin.url, url);
    data = webread(url, ValispaceLogin.options);
end
