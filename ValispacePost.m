function [ data ] = ValispacePost(url, data)
% Custom POST request to the Valispace REST API
    global ValispaceLogin
    
    if (length(ValispaceLogin) == 0)
        error('You first have to run ValispaceInit()');
    end

    url = strcat(ValispaceLogin.url, url);
    data = webwrite(url, data, ValispaceLogin.options);
end
