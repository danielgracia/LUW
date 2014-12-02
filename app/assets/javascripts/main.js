
function changeOrder(suffix){
	
	console.log("suffix gerada = " + suffix);
	$.ajax({
		type: "POST",
		url: "/postagem/busca/" + suffix,
		data: { 
			search: $("#search-keyword").val(),
			tags: $("#tags").val() //TODO
		},
		contentType: "application/json; charset=utf-8",
		dataType: "json",
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
		case "/sobre":
			$("#SobreLink").addClass('active');
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

function invite(){
	$('#result').removeClass();
	$("#result").innerHTML = "";
	var mail= $("#mail").val();
	console.log("Email para convidar: " + mail);
	$.ajax( {
		type: "POST",
		url: "/convidar",
		data: mail,
		async: false,
		success: function(data){
			console.log("Success: Convite");
			var html = "<div id='result' role='alert' class='alert alert-success'>Convite enviado com sucesso! </div>";
			$("#result").replaceWith(html);
			
		},
		error: function (e) {
			var html = "<div id='result' role='alert' class='alert alert-danger'>Falha no enviado do convite! Tente novamente.</div>";
			$("#result").replaceWith(html);
			
		}
	});  

}

function clearResult(){
	var html = "<div id='result' role='alert'></div>";
	$("#result").replaceWith(html);
}