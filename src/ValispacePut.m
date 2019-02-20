function [ out_data ] = ValispacePut(url, data)
% Custom POST request to the Valispace REST API
    global ValispaceLogin

    if (length(ValispaceLogin) == 0)
        error('You first have to run ValispaceInit()');
    end

    if isempty(strfind(url, 'http'))
        url = strcat(ValispaceLogin.url, url);
    end

    if verLessThan('matlab', '9.1')    % HeaderFields was introduced in 2016b (9.1)
        get_data = ValispaceGet(url);
        f = fieldnames(data);
        for i = 1:length(f)
            j = f{i};
            get_data.(j) = data.(j);
        end

        r = regexp(url, '^(.*/)(\d+)/?$', 'tokens');
        if length(r) ~= 0
            url = r{1}{1};
            get_data.('id') = str2num(r{1}{2});
            %data.('id') = str2num(r{1}{2});
        end

        out_data = ValispacePost(url, get_data
        % disp('Sorry, at the moment PUT is not available for your version of matlab (>2016b required).');
        % access = ValispaceLogin.options.KeyValue
        %json = '{}'
        % system(strcat('curl -H ''Authorization: ', access, ''' -H ''Content-Type: application/json'' -X PUT -d ''', json, ''' ', url))
    else
        options = ValispaceLogin.options;
        options.RequestMethod = 'PUT';
        options.MediaType = 'application/json';
        out_data = webwrite(url, data, options);
    end
end
