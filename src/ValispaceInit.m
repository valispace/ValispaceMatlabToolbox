function ValispaceInit(URL, APIToken, insecure)
    % ValispaceInit Initializes the connection to the Valispace API using an API Access Token
    %
    % Parameters:
    %   URL       - The base URL of the Valispace instance (e.g., 'https://demonstration.valispace.com')
    %   APIToken  - Your Valispace API Access Token
    %   insecure  - (Optional) If set to 'insecure', allows HTTP connections
    
    % Declare ValispaceLogin as global
    global ValispaceLogin

    %% Step 1: Validate Inputs
    if ~(ischar(URL) || isstring(URL)) || ~isscalar(URL)
        error('VALISPACE-ERROR: URL must be a scalar string or character vector.');
    end
    if ~(ischar(APIToken) || isstring(APIToken)) || ~isscalar(APIToken)
        error('VALISPACE-ERROR: APIToken must be a scalar string or character vector.');
    end

    %% Step 2: Check for SSL Connection
    if startsWith(URL, 'http://', 'IgnoreCase', true)
        if exist('insecure', 'var') && strcmpi(insecure, 'insecure')
            warning(['You are sending your credentials over an unencrypted connection. ' ...
                     'It is highly recommended to use "https://..." instead!']);
        else
            error(['VALISPACE-ERROR: You are attempting to send credentials over an unencrypted ' ...
                   'connection. Please use "https://..." for secure communication. ' ...
                   'If you intend to proceed with an insecure connection, use ValispaceInit() ' ...
                   'with "insecure" as the last argument.']);
        end
    end

    %% Step 3: Remove Trailing Slash from URL
    if endsWith(URL, '/')
        BasicUrl = extractBefore(URL, strlength(URL));
    else
        BasicUrl = URL;
    end

    % Ensure BasicUrl is scalar
    if ~isscalar(BasicUrl)
        error('VALISPACE-ERROR: BasicUrl is not scalar after removing trailing slash.');
    end

    %% Step 4: Configure HeaderFields with Bearer Token
    % Construct the Authorization header
    authHeader = ['Bearer ' char(APIToken)];

    % Verify authHeader is a scalar string or character vector
    if ~(ischar(authHeader) || isstring(authHeader)) || ~isscalar(authHeader)
        error('VALISPACE-ERROR: authHeader must be a scalar string or character vector.');
    end

    % Define HeaderFields as an Mx2 cell array
    headerFields = {...
        'Authorization', authHeader; ...
        'Content-Type', 'application/json' ...
    };

    %% Step 5: Configure Web Options with Correct HeaderFields
    try
        ValispaceLogin.options = weboptions(...
            'Timeout', 200, ...
            'HeaderFields', headerFields, ...
            'ContentType', 'json' ...
        );
    catch ME
        error(['VALISPACE-ERROR: Failed to set web options. ' ME.message]);
    end

    %% Step 6: Set the Base API URL
    ValispaceLogin.url = append(BasicUrl, '/rest/');

    % Ensure ValispaceLogin.url is scalar
    if ~isscalar(ValispaceLogin.url)
        error('VALISPACE-ERROR: ValispaceLogin.url is not scalar after concatenation.');
    end

    %% Step 7: Debugging - Display HeaderFields Structure and Base URL
    disp('HeaderFields Structure:');
    disp(ValispaceLogin.options.HeaderFields);

    disp('ValispaceLogin.url:');
    disp(ValispaceLogin.url);
    disp(['Class: ', class(ValispaceLogin.url)]);
    disp(['Size: ', mat2str(size(ValispaceLogin.url))]);
end
