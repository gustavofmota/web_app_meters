/*$(".meterBtn").on('click', function(e){
    $(this).parent().find('form').submit();
    debugger;
})

$('input[type=submit]').closest("form");*/

$(".button-4").on('click', function(e){
    e.stopPropagation();
    window.location.href=this.dataset.link;
});

$(".zoneWrapper").on("click", function (e) {
    e.preventDefault();
    location.href = "meters.jsp?zId=" + this.dataset.zid + "&hasError=";
});