function [ data ] = ValispacePut(url, data)
% Custom POST request to the Valispace REST API
    global ValispaceLogin

    if (length(ValispaceLogin) == 0)
        error('You first have to run ValispaceInit()');
    end

    url = strcat(ValispaceLogin.url, url);

    if verLessThan('matlab', '9.1')    % HeaderFields was introduced in 2016b (9.1)
        disp('Sorry, at the moment PUT is not available for your version of matlab (>2016b required).');
        % access = ValispaceLogin.options.KeyValue
        %json = '{}'
        % system(strcat('curl -H ''Authorization: ', access, ''' -H ''Content-Type: application/json'' -X PUT -d ''', json, ''' ', url))
    else
        options = ValispaceLogin.options;
        options.RequestMethod = 'PUT';
        options.MediaType = 'application/json';
        data = webwrite(url, data, options);
    end
end
