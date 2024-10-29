function ValispaceInit(URL, APIToken, insecure)
    % ValispaceInit Initializes the connection to the Valispace API using a Bearer Token
    %
    % Parameters:
    %   URL       - The base URL of the Valispace instance (e.g., 'https://demo.valispace.com')
    %   APIToken  - Your Valispace API Access Token
    %   insecure  - (Optional) If set to 'insecure', allows HTTP connections (not recommended)
    
    % Declare ValispaceLogin as global
    global ValispaceLogin
    
    %% Check Number of Inputs
    narginchk(2, 3); % URL and APIToken are required, insecure is optional
    
    %% Step 1: Validate Inputs
    if ~(ischar(URL) || isstring(URL)) || ~isscalar(URL)
        error('VALISPACE-ERROR: URL must be a scalar string or character vector.');
    end
    if ~(ischar(APIToken) || isstring(APIToken)) || ~isscalar(APIToken)
        error('VALISPACE-ERROR: APIToken must be a scalar string or character vector.');
    end
    
    %% Step 2: Check for SSL Connection
    if startsWith(URL, 'http://', 'IgnoreCase', true)
        if nargin == 3 && strcmpi(insecure, 'insecure')
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
    
    %% Step 4: Construct Authorization Header
    authHeader = sprintf('Bearer %s', APIToken);
    
    %% Step 5: Validate authHeader
    if ~(ischar(authHeader) || isstring(authHeader)) || ~isscalar(authHeader)
        error('VALISPACE-ERROR: authHeader must be a scalar string or character vector.');
    end
    
    %% Step 6: Define HeaderFields as Mx2 Cell Array
    headerFields = {...
        'Authorization', authHeader; ...
        'Content-Type', 'application/json' ...
    };
    
    %% Step 7: Configure Web Options with HeaderFields
    try
        ValispaceLogin.options = weboptions(...
            'Timeout', 200, ...
            'HeaderFields', headerFields, ...
            'ContentType', 'json' ...
        );
    catch ME
        error(['VALISPACE-ERROR: Failed to set web options. ' ME.message]);
    end
    
    %% Step 8: Set the Base API URL
    ValispaceLogin.url = append(BasicUrl, '/rest/');
    
    %% Step 9: Verify and Display Configuration
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
