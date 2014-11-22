window.onload = function(event) {
	
	var dataUser = JSON.parse(window.localStorage.getItem("user"));
	
	if (!dataUser || dataUser.logged == false){
		event.stopPropagation(true);
    	window.location.href="login.html";
	}
};

var sharedApp = angular.module('sharedApp', ['sharedModule']);


function logout(){
	var dataUser = JSON.parse(window.localStorage.getItem("user"));
	dataUser.logged = false;
	window.localStorage.setItem("user", JSON.stringify(dataUser));
	location.reload(true);
}

function SharedController($scope){
	$scope.user = {nome: "Admin"};

}