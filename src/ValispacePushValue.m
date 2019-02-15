function [ ExecutionStatus ] = ValispacePushValue(name_or_id, value)
% pushes a Value to Valispace

    global ValispaceLogin

    if (length(ValispaceLogin)==0)
        error('You first have to run ValispaceInit()');
    end

    % use name instead of ID
    if (class(name_or_id) == 'string')
        name_or_id = ValispaceName2Id(name_or_id);
    end

    write_options = ValispaceLogin.options;
    write_options.RequestMethod = 'put';
    write_options.MediaType = 'application/json';

    url = strcat(ValispaceLogin.url, 'vali/', string(name_or_id), '/');

    read_vali = webread(url, ValispaceLogin.options);
    
    write_vali = read_vali;

    % remove read-only fields
    write_vali = rmfield(write_vali,{'id','path','name','value','uses_default_formula','totalmargin_plus','totalmargin_minus','wc_plus','wc_minus','is_part_of_linking_matrix','mathjax_formula','mathjax_formula_simple','valis_used', 'function_data', 'project', 'project_name', 'baseunit', 'value_baseunit', 'valis_marked_as_impacted', 'valis_marked_to_impact_this_vali', 'used_by_simulations', 'source_simulation', 'is_part_of_matrix', 'subscribed', 'old_value', 'type_name', 'used_by_valis', 'data_type', 'function_view_plot_min', 'function_view_plot_max'});
     
	% remove empty fields
	fields = fieldnames(write_vali);
	for i = 1:numel(fields)
		if isempty(write_vali.(fields{i}))
            display(fields(i))
			write_vali = rmfield(write_vali,fields(i));
		end
    end
    % set formula
    write_vali.formula = string(value);
    ReturnVali = webwrite(url,write_vali,write_options);

    display(strcat('Successfully pushed ', ReturnVali.name, ' = ', string(ReturnVali.value), ' ', ReturnVali.unit, ' to Valispace.'));
end