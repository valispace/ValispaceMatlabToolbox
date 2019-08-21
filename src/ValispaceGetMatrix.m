function [ Matrix, MatrixNames, MatrixValiIDs ] = ValispaceGetMatrix(id)
% ValispaceGetMatrix() returns a Matlab Matrix with the values, one with
% the names and one with the ValiIDs
    global ValispaceLogin
    global ValiList
    
    if (length(ValispaceLogin)==0) 
        error('VALISPACE-ERROR: You first have to run ValispaceInit()');
    end
    
  

    url = strcat(ValispaceLogin.url, 'matrix/', num2str(id), '/');
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