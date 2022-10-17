function topBanner(){
    banner.innerHTML = '<i>Welcome back, <b>'+firstName+'</b> (<a href="/logout">logout</a>)'
}

var banner = document.getElementById("loggedInInfo")
if (firstName != "Guest" && firstName != ""){
    topBanner()
}
else{
    banner.classList.add("hidden")
}