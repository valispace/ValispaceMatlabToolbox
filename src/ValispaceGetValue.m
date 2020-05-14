function [ Value ] = ValispaceGetValue(name_or_id)
%ValispaceGetValue returns the correct Value. Input can be ID or name
    Vali = ValispaceGetVali(name_or_id);
    if ~isfield(Vali,'value') %It may be a matrix instead for example
       error('VALISPACE-ERROR: Vali not found! Perhaps you meant to use ValispaceGetMatrix(..)?') 
    end
    Value = Vali.value;
end