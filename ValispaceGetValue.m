function [ Value ] = ValispaceGetValue(name_or_id)
%ValispaceGetValue returns the correct Value. Input can be ID or name
    Vali = ValispaceGetVali(name_or_id);
    Value = Vali.value;
end