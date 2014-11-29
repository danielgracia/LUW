function changeOrder(sufix){
	
	console.log("sufix gerada = " + sufix);
	var keyword= $("#search").val(); 
	var dataE = { "keyword": keyword };
	$.ajax( {
		type: "POST",
		url: "/busca/" + sufix,
		data: dataE,
		contentType: "application/json; charset=utf-8",
		dataType: "json",
		async: false,
		success: function(data){
		},
		error: function (e) {
		}
	});  
}