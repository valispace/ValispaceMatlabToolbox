function [ Vali ] = ValispaceGetVali(name_or_id)
%ValispaceGetVali returns the correct Vali. Input can be ID or name
    global ValispaceLogin
    global ValiList
    id = 0;
    
    if (length(ValispaceLogin)==0) 
        error('VALISPACE-ERROR: You first have to run ValispaceInit()');
    end
    
    if ((length(ValiList)==0) && (class(name_or_id) == 'string'))
        error('VALISPACE-ERROR: If you use this function with a string (Vali-Name), you first need to call ValispacePull().'); 
    end
    
    if (length(ValiList)==0) % ValispacePull() has not been called and therefore the API is accessed directly
        id = name_or_id;
        url = strcat(ValispaceLogin.url, 'vali/', id, '/');
        Vali = webread(url, ValispaceLogin.options);
    else    
        if (class(name_or_id) == 'string') % A name has been provided
            [id, Vali] = ValispaceName2Id(name_or_id)
        else % A number has been provided
            for vali = ValiList
                if (vali.id == name_or_id)
                    Vali = vali;
                    id = vali.id;
                end
            end
        end

        if (id == 0)
            error('VALISPACE-ERROR: Vali not found')
        end
    end
end