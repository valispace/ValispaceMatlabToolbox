function ValispaceInit(URL, Username, Password, insecure)
    % ValispaceInit Initializes the connection to the Valispace API using Basic Authentication
    %
    % Parameters:
    %   URL       - The base URL of the Valispace instance (e.g., 'https://demonstration.valispace.com')
    %   Username  - Your Valispace username
    %   Password  - Your Valispace password
    %   insecure  - (Optional) If set to 'insecure', allows HTTP connections

    % Declare ValispaceLogin as global
    global ValispaceLogin

    %% Step 1: Validate Inputs
    if ~(ischar(URL) || isstring(URL)) || ~isscalar(URL)
        error('VALISPACE-ERROR: URL must be a scalar string or character vector.');
    end
    if ~(ischar(Username) || isstring(Username)) || ~isscalar(Username)
        error('VALISPACE-ERROR: Username must be a scalar string or character vector.');
    end
    if ~(ischar(Password) || isstring(Password)) || ~isscalar(Password)
        error('VALISPACE-ERROR: Password must be a scalar string or character vector.');
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

    %% Step 4: Encode Credentials for Basic Authentication
    credentials = [char(Username) ':' char(Password)];  % Ensure inputs are character vectors
    encodedCredentials = matlab.net.base64encode(credentials);
    authHeader = ['Basic ' encodedCredentials];

    %% Step 5: Configure HeaderFields Correctly
    headerFields = {...
        'Authorization', authHeader; ...
        'Content-Type', 'application/json' ...
    };

    %% Step 6: Configure Web Options with Correct HeaderFields
    ValispaceLogin.options = weboptions(...
        'Timeout', 200, ...
        'HeaderFields', headerFields, ...
        'ContentType', 'json' ...
    );

    %% Step 7: Debugging - Display HeaderFields Structure
    %% disp('HeaderFields Structure:');
    % disp(ValispaceLogin.options.HeaderFields);

    % Additional Debugging: Verify HeaderFields type and size
    % disp('HeaderFields Class:');
    % disp(class(ValispaceLogin.options.HeaderFields));

    % disp('HeaderFields Size:');
    % disp(size(ValispaceLogin.options.HeaderFields));

    %% Step 8: Set the Base API URL
    ValispaceLogin.url = append(BasicUrl, '/rest/');

    % Ensure ValispaceLogin.url is scalar
    if ~isscalar(ValispaceLogin.url)
        error('VALISPACE-ERROR: ValispaceLogin.url is not scalar after concatenation.');
    end

    %% Step 9: Debugging - Display ValispaceLogin.url
    disp('ValispaceLogin.url:');
    disp(ValispaceLogin.url);
    % disp(['Class: ', class(ValispaceLogin.url)]);
    % disp(['Size: ', mat2str(size(ValispaceLogin.url))]);
end
