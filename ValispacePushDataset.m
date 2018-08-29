function [ ExecutionStatus ] = ValispacePushDataset(name_or_id, dataset)
% pushes a Value to Valispace
[sizei,sizej]=size(dataset);

    global ValispaceLogin
    
    if (length(ValispaceLogin)==0)
        error('You first have to run ValispaceInit()');
    end

    % use name instead of ID
    if (class(name_or_id) == "string")
        name_or_id = ValispaceName2Id(name_or_id);
    end
    
    write_options = ValispaceLogin.options;
    write_options.RequestMethod = "post";
    write_options.MediaType = "application/json";
    
    url = ValispaceLogin.url + "vali/" + string(name_or_id) + "/import-dataset/";
       
    % set dataset
    for j=1:sizej
        data{j,1}(1,1)=dataset(1,j);
        data{j,1}(2,1)=dataset(2,j);
    end
    post_data.data = data;
    ReturnVali = webwrite(url,post_data,write_options);
    display("Successfully updated Dataset!");
    
    %display("Successfully pushed " + ReturnVali.name + " = " + string(ReturnVali.value) + " " + ReturnVali.unit + " to Valispace.");
end