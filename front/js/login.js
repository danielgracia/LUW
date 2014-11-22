
$('#signin').on('click', function (e) {
	console.log("Entrei no cadastrar");
	var email = $("#email").val();
	var userid = $("#userid").val();
	var password = $("#password").val();
	var reenterpassword = $("#reenterpassword").val();
	if(password == reenterpassword){
		var dataUser = {
			"email": email,
			"userid": userid,
			"password": password,
			"logged": false
		}
		window.localStorage.setItem("user", JSON.stringify(dataUser));
	}
	else{
		var container = document.getElementById('result');
		container.innerHTML = 'Senhas diferem, tente novamente';
	}

})

$('#confirmsignup').on('click', function (e) {
	console.log("Entrei no login");
	var email = $("#email").val();
	var userid = $("#userid").val();
	var password = $("#password").val();
	var dataUser = JSON.parse(window.localStorage.getItem("user"));
	if(password == dataUser.password){
		dataUser.logged = true;
		window.localStorage.setItem("user", JSON.stringify(dataUser));
	}
	else{
		var container = document.getElementById('result');
		container.innerHTML = 'Senha errada...';
	}

})
