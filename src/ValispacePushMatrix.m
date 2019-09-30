function ValispacePushMatrix(id,Matrix)
% ValispacePushMatrix() pushes a Matlab Matrix with the values
    global ValispaceLogin

    if (length(ValispaceLogin)==0) 
        error('VALISPACE-ERROR: You first have to run ValispaceInit()');
    end
  
    url = strcat(ValispaceLogin.url, 'matrices/', id, '/');
    MatrixData = webread(url, ValispaceLogin.options);
    
    
    
    if not (isequal(size(Matrix),[MatrixData.number_of_rows,MatrixData.number_of_columns]))
        error('VALISPACE-ERROR: The dimensions of the local and the remote matrix do not match.');
    end
    
    for column = 1:MatrixData.number_of_columns
       for row = 1:MatrixData.number_of_rows
           ValispacePushValue(MatrixData.cells(row,column),Matrix(row,column));
       end
    end
    
    [ Matrix, MatrixNames, MatrixValiIDs ] = ValispaceGetMatrix(id);
    
    
end