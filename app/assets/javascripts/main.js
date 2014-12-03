
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
			$('#tags').tagsinput({
				elemControlSize: true,
				typeahead :
				{
					items: 4,
					source: ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Dakota","North Carolina","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
				}
			});
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

// Upvotes e downvotes
$(document).ready(function(){
  $(".content-upvote,.content-downvote").parent().on("ajax:success", function(_, data){
  	$("#content-score").text(data.value);
  });

  $(".comment-upvote,.comment-downvote").each(function(){
  	var $score = $(this).parent().find(".score");
  	$(this).parent().on("ajax:success", function(_, data){
	    $score.text(data.value);
	  });
  });
});
