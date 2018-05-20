$(document).ready(function(){
    $(".col-actions").append("<p></p>");
    if( $("th")[11]){
    $("th")[11].childNodes[0].innerHTML="Actions"
    }else if( $("th")[8]){
        $("th")[8].childNodes[0].innerHTML="Actions"
    }
    else if( $("th")[6]){
        $("th")[6].childNodes[0].innerHTML="Actions"
    }
})
