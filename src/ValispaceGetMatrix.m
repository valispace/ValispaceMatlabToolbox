function [ Matrix, MatrixNames, MatrixValiIDs ] = ValispaceGetMatrix(name_or_id)
% ValispaceGetMatrix() returns a Matlab Matrix with the values, one with
% the names and one with the ValiIDs
    global ValispaceLogin
    global ValiList
    global MatrixData
    
    if (length(ValispaceLogin)==0) 
        error('VALISPACE-ERROR: You first have to run ValispaceInit()');
    end
    
    % use name instead of ID
    if (isa(name_or_id, 'string') || isa(name_or_id, 'char'))
        name_or_id = ValispaceName2Id(name_or_id);
    end

    url = strcat(ValispaceLogin.url, 'matrices/', num2str(name_or_id), '/');
    MatrixData = webread(url, ValispaceLogin.options);
  
    Matrix = [];
    MatrixNames = string([]); % create empty string array
    
    for column = 1:MatrixData.number_of_columns
       for row = 1:MatrixData.number_of_rows
           Vali = ValispaceGetVali(MatrixData.cells(row,column));
           Matrix(row,column) = Vali.value;
           MatrixNames(row,column) = Vali.name;
           MatrixValiIDs(row,column) = Vali.id;
       end
    end
    
end