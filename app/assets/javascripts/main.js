var shortcut;
var keyword;
var search_feed;

function changeOrder(suffix){
	console.log("suffix gerada = " + suffix);
	$.ajax({
		type: "GET",
		url: "/postagens/busca/",
		data: { 
			search: $("#search-keyword").val(),
			tags: $("#tags").val(), //TODO
			rank_by: suffix,
		},
		dataType: "json",
		success: function(data){
			console.log(data);
			if (data.result == ""){
				console.log("RESULTADO VAZIO");
				$("#feed-list").html("<div id='result' role='alert' class='alert alert-warning'>Nenhum resultado obtido na pesquisa!</div>");
			}
			else{
				console.log("ACHOU ALGO...");
				$("#feed-list").html(data.result);
			}
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
			console.log("SEARCH PAGE SHORTCUT? = " + window.shortcut);
			$("#NavegarLink").addClass('active');
			$('#tags').tagsinput({
				elemControlSize: true,
				typeahead :
				{
					items: 4,
					source: ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Dakota","North Carolina","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
				}
			});
			$('#tags').on('itemAdded', function(event) {
  				changeOrder('best');
			});
			if(window.shortcut){
				$("#search-keyword").val(keyword);
				console.log("search feed = " + search_feed);
				window.shortcut = false;
			}
			break;
		case "/postagem/nova":
			$("#NovoLink").addClass('active');
			$("#tags").tagsinput({
            elemControlSize: true,
            typeahead :
            {
              items: 4,
              source: function(query, cb){
                $.get('/sugestoes', {
                  query: query
                }, function(result){
                  qb(result);
                });
              }
            }
                                  });
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
		url: "/postagens/busca",
		data: { 
			search: $("#search-shortcut").val(),
			tags: "",
			rank_by: "best",
		},
		dataType: "json",
		success: function(data){
			console.log("Success: " + data);
			window.shortcut = true;
			console.log("changing shortcut to " + window.shortcut)
			search_feed = data;
			$(location).attr('href', '/postagens');
			
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

function vote(action, id){
	
	console.log("ID DO TOPICO = " + id + " ACAO = " + action);
	
	$.ajax( {
		type: "POST",
		url: "/postagem/" + id + "/" + action,
		success: function(data){
			var score = $("#score").html();
			if (action == 'downvote') score -= 1;
			if(action == 'upvote') score += 1;
			$("#score").html(score);
		},
		error: function (e) {
		}
	});  

}

function logout(){
	$.ajax( {
		type: "POST",
		url: "/logout",
		success: function(data){
			console.log("DESLOGADO: " + data);
			$(location).attr('href', '/login');
		},
		error: function (e) {
		}
	}); 
	return false; 
}

function editPost(){
	var container = $("#content");
	$("#edit-area").toggle();
	var backup = container.html();
	//ajaxLoad(backup);

}

function ajaxLoad(text) {
        var ed = tinyMCE.get('edit');
        ed.setProgressState(1); // Show progress
        window.setTimeout(function() {
            ed.setProgressState(0); // Hide progress
            ed.setContent(text);
        }, 1);
 }