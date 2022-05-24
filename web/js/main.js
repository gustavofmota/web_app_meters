
$(".edit").on('click', function(e){
    e.stopPropagation();
    window.location.href=this.dataset.link;
    $('#change').attr('value','edit');

});

$(".delete").on('click', function(e){
    e.preventDefault();
    window.location.href=this.dataset.link;
});

$(".zoneClick").on("click", function (e) {
    e.preventDefault();
    location.href = "meters.jsp?zId=" + this.dataset.zid + "&hasError=";
});



/*
//url Script
function getURLParameter(name) {
    return decodeURI((RegExp(name + '=' + '(.+?)(&|$)').exec(location.search)||[,null])[1]);
}
function hideURLParams() {
    //Parameters to hide (ie ?success=value, ?error=value, etc)
    var hide = ['success','error'];
    for(var h in hide) {
        if(getURLParameter(h)) {
            history.replaceState(null, document.getElementsByTagName("title")[0].innerHTML, window.location.pathname);
        }
    }
}

//Run onload, you can do this yourself if you want to do it a different way
window.onload = hideURLParams;*/