function [ id, Vali ] = ValispaceName2Id(name)
    global ValiList
    global ValiMatrixList
    
    id = 0;
    Vali = [];
    
    if (length(ValiList)==0)
        error('VALISPACE-ERROR: If you use this function with a string (Vali-Name), you first need to call ValispacePull().'); 
    end
      
    for vali = ValiList
        if (strcmp(lower(vali.name), lower(name)) == 1)
            Vali = vali;
            id = vali.id;
        end
    end
    
    if (id == 0)
        for matri = ValiMatrixList
            if (strcmp(lower(matri.unique_name), lower(name)) == 1)
                Vali = matri;
                id = matri.id;
            end
        end
        if(id == 0)
            error('VALISPACE-ERROR: Vali not found')
        end
    end
end