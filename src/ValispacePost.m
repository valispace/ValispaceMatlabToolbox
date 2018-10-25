function [ data ] = ValispacePost(url, data)
% Custom POST request to the Valispace REST API
    global ValispaceLogin

    if (length(ValispaceLogin) == 0)
        error('You first have to run ValispaceInit()');
    end

    options = ValispaceLogin.options;

    options.RequestMethod = 'POST';
    options.MediaType = 'application/json';

    url = strcat(ValispaceLogin.url, url);
    data = webwrite(url, data, options);
end
