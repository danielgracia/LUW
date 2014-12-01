
function changeOrder(sufix){
	
	console.log("sufix gerada = " + sufix);
	var keyword= $("#search-keyword").val(); 
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

function setLocation(){
	var pathname = window.location.pathname;
	console.log("Local: " + pathname);
	switch(pathname){
		case "/":
			$("#HomeLink").addClass('active');
			break;
		case "/postagens":
			$("#NavegarLink").addClass('active');
			
			break;
		case "/postagem/nova":
			$("#NovoLink").addClass('active');
			break;
		default:
			break;
	}


}

function searchShortcut(){
	var keyword= $("#search-shortcut").val();
	console.log("Current location:", window.location.href);
	$.ajax( {
		type: "GET",
		url: "/postagens",
		dataType: 'html',
		async: false,
		success: function(data){
			console.log("Success: ");
			document.body.innerHTML = data;
			$("#search-keyword").val(keyword);
		},
		error: function (e) {
		}
	});  
	return false;
}