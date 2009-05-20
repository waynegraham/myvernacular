function GetREST(user_opts){
	
	var $ = jQuery;
	
	var default_opts = {
		base_uri : '',
		base_path : '/',
		default_params : {}
	}
	
	var default_opts = $.extend(true, default_opts, user_opts);
	
	/*
	* Converts an object (Hash) into a query string
	*/
	function object_to_query(obj){
		var query = [];
		for(i in obj){ query.push(i + '=' + obj[i]) }
		return query.join('&');
	}
	
	/*
	* takes an array of arguments and returns an options object
	*/
	function extract_request_opts(source_args){
		var args=[];
		for(i=0; i < source_args.length; i++){ args.push(source_args[i]) }
		var rpath = '';
		var rparams = {};
		if(typeof args[0] == 'string'){ rpath = args.shift() }
		if(typeof args[0] == 'object'){ rparams = args.shift() }
		rparams.jsoncallback = '?';
		params = $.extend(true, default_opts.default_params, rparams);
		return {
			callback:args.shift(),
			uri : (default_opts.base_uri + default_opts.base_path + rpath),
			params : params,
			query : object_to_query(params)
		};
	}
	
	return {
		
		/*
		* Performs a jQuery getJSON operation.
		* argument 1 is either a string (the resource path): '/admin'
		* OR 
		* an param object: {:user_id:100}
		* *if* the first argument is a string, the second can be the param object.
		* The last argument must always be a callback function which accepts one argument (the response data)
		*/
		get : function(){
			opts = extract_request_opts(arguments);
			var cb = function(data){
				opts.callback(data, opts);
			}
			$.getJSON(opts.uri, opts.query, cb);
		}
		
	}
}