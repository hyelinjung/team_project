$(document).ready(function(){
 let getCount = localStorage.getItem('bellCount')
    console.log(getCount);
    if( getCount !== '0'){
    console.log('값이 있음');
     $('#count_text').css('display','block');
     $('#count_text').css('background-color','tomato');
     $('#count_text').text(getCount);

    }
 });