function ValispaceInit(URL, APIToken)
    % ValispaceInit Initializes the connection to the Valispace API using a Bearer Token
    %
    % Parameters:
    %   URL       - The base URL of the Valispace instance (e.g., 'https://demonstration.valispace.com')
    %   APIToken  - Your Valispace API Access Token

    % Remove global declaration and use a local structure

    %% Check Number of Inputs
    narginchk(2, 2); % Only URL and APIToken are required

    %% Step 1: Validate Inputs
    if ~(ischar(URL) || isstring(URL)) || ~isscalar(URL)
        error('VALISPACE-ERROR: URL must be a scalar string or character vector.');
    end
    if ~(ischar(APIToken) || isstring(APIToken)) || ~isscalar(APIToken)
        error('VALISPACE-ERROR: APIToken must be a scalar string or character vector.');
    end

    %% Step 2: Enforce SSL Connection
    if startsWith(URL, 'http://', 'IgnoreCase', true)
        error(['VALISPACE-ERROR: Insecure connections are not allowed. ' ...
               'Please use "https://..." for secure communication.']);
    end

    %% Step 3: Remove Trailing Slash from URL
    if endsWith(URL, '/')
        BasicUrl = extractBefore(URL, strlength(URL));
    else
        BasicUrl = URL;
    end

    %% Step 4: Construct Authorization Header
    authHeader = sprintf('Bearer %s', APIToken);

    %% Step 5: Define HeaderFields as Mx2 Cell Array
    headerFields = {...
        'Authorization', authHeader; ...
        'Content-Type', 'application/json' ...
    };

    %% Step 6: Configure Web Options with HeaderFields
    try
        ValispaceLogin.options = weboptions(...
        ValispaceLogin.options = weboptions(...
            'Timeout', 200, ...
            'HeaderFields', headerFields, ...
            'ContentType', 'json' ...
        );
        error(['VALISPACE-ERROR: Failed to set web options. ' ME.message]);
    end

    %% Step 7: Set the Base API URL
    ValispaceLogin.url = append(BasicUrl, '/rest/');

    %% Step 8: Verify and Display Configuration
    % Check if ValispaceLogin.url is scalar
    if ~isscalar(ValispaceLogin.url)
        error('VALISPACE-ERROR: ValispaceLogin.url is not scalar after concatenation.');
    end

    % Display HeaderFields Structure
    disp('HeaderFields Structure:');
    disp(ValispaceLogin.options.HeaderFields);

    % Display Base URL
    disp('ValispaceLogin.url:');
    disp(ValispaceLogin.url);
    disp(['Class: ', class(ValispaceLogin.url)]);
    disp(['Size: ', mat2str(size(ValispaceLogin.url))]);
end
