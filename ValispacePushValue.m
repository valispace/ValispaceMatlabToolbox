function [ ExecutionStatus ] = ValispacePushValue(name_or_id, value)
% pushes a Value to Valispace
% TBD also 

    global ValispaceLogin
    
    if (length(ValispaceLogin)==0)
        error('You first have to run ValispaceInit()');
    end

    % use name instead of ID
    if (class(name_or_id) == "string")
        name_or_id = ValispaceName2Id(name_or_id);
    end
    
    write_options = ValispaceLogin.options;
    write_options.RequestMethod = "patch";
    write_options.MediaType = "application/json";
    
    url = ValispaceLogin.url + "vali/" + string(name_or_id) + "/";
       
    % set new formula
    write_vali.formula = string(value);

    ReturnVali = webwrite(url,write_vali,write_options);
  
    display("Successfully pushed " + ReturnVali.name + " = " + string(ReturnVali.value) + " " + ReturnVali.unit + " to Valispace.");
end