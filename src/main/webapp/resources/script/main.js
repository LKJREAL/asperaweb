 $(document).ready(function(){
     
     // 슬라이더 페이지 번호 불러오기
function pageNumberInit(){
    var totalSlideNo = $('.banner').length;
   /* console.log(totalSlideNo);*/
     $('.total_slide_no').text(totalSlideNo);
    
};
     pageNumberInit();
     
     //슬라이더 페이지번호 변경
     var slideNo=1;
     
     $('.current_slide_no').text(slideNo);
     $('.visual .next_btn').click(function(){
         if(slideNo < 3) {
           slideNo++;
            $('.current_slide_no').text(slideNo);
         }
     });
     $('.visual .prev_btn').click(function(){
         if(slideNo > 1) {
           slideNo--;
            $('.current_slide_no').text(slideNo);
         }
     });
     
     //재생버튼
     $('.stop_icon').click(function(){
         $(this).hide();
         $('.playBtn .play_icon').show();
         $('#slider').get(0).pause();
         $('svg circle:nth-child(2)').css('animation-play-state','paused');
     });
          $('.playBtn .play_icon').click(function(){
         $(this).hide();
         $('.playBtn .stop_icon').show();
         $('#slider').get(0).play();
         $('svg circle:nth-child(2)').css('animation-play-state','running');
     });
     
     
     //sec1 
      $(window).resize(function() { 
        var sliderHeight1=Number($('.banner video').height())
        $('.banner_wrap, .visual, .banner, .banner2 img').height(sliderHeight1);
    }); 
     /*처음 로딩될때 화면 크기 설정*/
  var sliderHeight1=Number($('.banner video').height())
        $('.banner_wrap, .visual, .banner, .banner2 img').height(sliderHeight1);
     
     
     //sec2 영역 화면 크기 조절
     
    $(window).resize(function() { 
        var imgHeight1=Number($('.new_product img').height()),
            imgHeight2=Number($('.sec2_new .title').outerHeight()),
            imgHeight=imgHeight1 + imgHeight2;
        $('.sec2_new').height(imgHeight);
    }); 
     /*처음 로딩될때 화면 크기 설정*/
     var imgHeight1=Number($('.new_product img').height()),
        imgHeight2=Number($('.sec2_new .title').outerHeight()),
        imgHeight=imgHeight1 + imgHeight2;
    $('.sec2_new').height(imgHeight);
     
   //갤러리 영역 730px 일때
     $(window).resize(function() { 
         
           var mobile_width=$(window).width();
      
     });
     
       var thumbnail=('.frame_wrap .right > div a');
     
            $(thumbnail).click(function(){
                var img=$(this).attr('href');
                var imgTag='<img src='+img+'>';
                var bigImg=('.frame_wrap .left > div'),
                    mobile_width=$(window).width();
                
                 if(mobile_width < 730) {
                    $('.frame_wrap .left > div img').before(imgTag);
                     
                    $('.frame_wrap .left > div img:last').fadeOut(500, function(){
                        
                     $('.frame_wrap .left > div img').not('img:first').remove();
                    }); /*첫번째 요소 빼고 전부다 제거*/
                     
                 };
           return false;
        });
 });     
     
     
     
     
     
     
     
     
     
     