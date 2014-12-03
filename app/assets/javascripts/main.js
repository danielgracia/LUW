
// set focus when modal is opened
$('#modal-confirm').on('shown.bs.modal', function (e) {
    //get data-id attribute of the clicked element
    var commentId = $(e.relatedTarget).data('id');
    var topicId = $(e.relatedTarget).data('topic');

    console.log("ID = " + commentId + " TOPIC =" + topicId);

    //populate the textbox
    $(e.currentTarget).find('form[id= formId]').val("postagem/" + topicId + "/comentario/" + commentID + "/deletar");
    $('#formId').attr('action', "postagem/" + topicId + "/comentario/" + commentID + "/deletar");
});

// everytime the button is pushed, open the modal, and trigger the shown.bs.modal event
$('#openConfirm').click(function (e) {
	console.log("CLICK KCT");
    $('#modal-confirm').modal({
        show: true
    });
    return false;
});

function changeOrder(suffix){
	console.log("suffix gerada = " + suffix);
	$.ajax({
		type: "GET",
		url: "/postagens/busca",
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
	return false;
}


function setLocation(sugestoes){
	var pathname = window.location.pathname;
	console.log("Local: " + pathname);

	switch(pathname){
		case "/":
			$("#HomeLink").addClass('active');
			break;
		case "/postagens":
			
			$("#NavegarLink").addClass('active');
			
			console.log(sugestoes);
			$('#tags').tagsinput({
				elemControlSize: true,
				typeahead :
				{
					items: 4,
					source: sugestoes
				}
			});
			$('#tags').on('itemAdded', function(event) {
  				changeOrder('best');
			});
			break;
		case "/postagem/nova":
			$("#NovoLink").addClass('active');
			$('#tags').tagsinput({
					elemControlSize: true,
					typeahead :
					{
						items: 4,
						source: sugestoes
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

function getTagSuggestions(){
	$.ajax( {
		type: "GET",
		url: "/sugestoes",
		success: setLocation,
		error: function (e) {
		}
	});  
}

function getURLParameter(name) {
    return decodeURI(
        (RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]
    );
}

function redirectSearch(){
	window.location.href = "/postagens" + "?search=" + $("#search-shortcut").val();
	return false;
}

function invite(){
	$('#result').removeClass();
	$("#result").innerHTML = "";
	$("#spinner").show();
	var mail= $("#email").val();
	console.log("Email para convidar: " + mail);
	$.ajax( {
		type: "POST",
		url: "/convidar",
		data: { email: mail },
		success: function(data){
			console.log("Success: Convite");
			var html = "<div id='result' role='alert' class='alert alert-success'>Convite enviado com sucesso! </div>";
			$("#result").replaceWith(html);
			$("#spinner").hide();
			
		},
		error: function (e) {
			var html = "<div id='result' role='alert' class='alert alert-danger'>Falha no enviado do convite! Tente novamente.</div>";
			$("#result").replaceWith(html);
			$("#spinner").hide();
			
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
  	$(".content-score").text(data.value);
  });

  $(".comment-upvote,.comment-downvote").each(function(){
  	var $score = $(this).parent().siblings().find(".score");
  	$(this).parent().on("ajax:success", function(_, data){
	    $score.text(data.value);
	  });
  });
});

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

