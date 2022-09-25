$(document).ready(function(){
    var TOP=$(window).scrollTop();
     $(window).scroll(function(){
         TOP=$(window).scrollTop();
         console.log(TOP)
    var serTitleOffset= $('.sec1 .title').offset().top; 
   /* console.log(serTitleOffset);*/
    serTitleOffset2=Number(serTitleOffset); 
    serTitleOffset=serTitleOffset-700;
    
    if(TOP>serTitleOffset){
       $('.sec1 .title, .sec1 .content').addClass('on');
       };
         
     var sec2_Offset= $('.sec2_content').offset().top; 
   /* console.log(sec2_Offset);*/
    sec2_Offset2=Number(sec2_Offset); 
    sec2_Offset=sec2_Offset-600;
    
    if(TOP>sec2_Offset){
       $('.sec2_content img, .sec2_content .text').addClass('on');
       };      
    
      var sec3_TopOffset= $('.sec3_wrap .top').offset().top; 
   /* console.log(sec2_Offset);*/
    sec3_TopOffset2=Number(sec3_TopOffset); 
    sec3_TopOffset=sec3_TopOffset-500;
    
    if(TOP>sec3_TopOffset){
       $('.sec3 .top img, .sec3 .top .img_text').addClass('on');
       };       
  
       var sec3_BottomOffset= $('.sec3_wrap .bottom').offset().top; 
    console.log(sec2_Offset);
    sec3_BottomOffset2=Number(sec3_BottomOffset); 
    sec3_BottomOffset=sec3_BottomOffset-600;
    
    if(TOP>sec3_BottomOffset){
       $('.sec3 .bottom img, .sec3 .bottom .img_text').addClass('on');
       };    
         
     });
    
    
    $(window).resize(function(){
        var sec2Height=Number($('.sec2_content img').height());
        
        $('.sec2_content').height(sec2Height);
    });
    
    var sec2Height=Number($('.sec2_content img').height());
    $('.sec2_content').height(sec2Height);
});