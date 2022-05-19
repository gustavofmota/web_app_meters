/*$(".meterBtn").on('click', function(e){
    $(this).parent().find('form').submit();
    debugger;
})

$('input[type=submit]').closest("form");*/

$(".button").on('click', function(e){
    e.stopPropagation();
    window.location.href=this.dataset.link;

});

$(".zoneClick").on("click", function (e) {
    e.preventDefault();
    location.href = "meters.jsp?zId=" + this.dataset.zid + "&hasError=";
});