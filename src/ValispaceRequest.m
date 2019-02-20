function [ out_data ] = ValispaceRequest(method, url, data)
% Custom POST request to the Valispace REST API
    global ValispaceLogin

    if (length(ValispaceLogin) == 0)
        error('You first have to run ValispaceInit()');
    end

    options = ValispaceLogin.options;

    options.RequestMethod = method;
    options.MediaType = 'application/json';

    if isempty(strfind(url, 'http') ~= 1)
        url = strcat(ValispaceLogin.url, url);
    end

    out_data = webwrite(url, data, options);
end
