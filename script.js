$(document).ready(function() {
    var $item = $('.carousel-item'); 
    var $wHeight = $(window).height();
    $item.eq(0).addClass('active');
    $item.height($wHeight); 
    $item.addClass('full-screen');

    $('.carousel img').each(function() {
        var $src = $(this).attr('src');
        $(this).parent().css({
            'background-image' : 'url(' + $src + ')',
        });
        $(this).remove();
    });

    $(window).on('resize', function () {
        $wHeight = $(window).height();
        $item.height($wHeight);
    });

    $('.carousel').carousel({
        interval: 5000,
        pause: "false"
    });

    // Skills section carousel
    $('.owl-carousel').owlCarousel({
        nav:true,
        loop:true,
        items: 4,
        responsive:{ 0: { items: 1 }, 480: { items: 2 }, 768: { items: 3 }, 938: { items:4 } }
    })

    // smooth scroll
    $("#navigation li a").click(function(e) {
        e.preventDefault()
        let targetElement = $(this).attr("href")
        let targetPosition = $(targetElement).offset().top
        $("html, body").animate({ scrollTop: targetPosition - 50 }, "slow")
    })

    // sticky nav
    const nav = $("#navigation")
    const navTop = nav.offset().top 
    
    $(window).on("scroll", stickyNavigation)
    
    function stickyNavigation() {
        const body = $("body")
        if ($(window).scrollTop() >= navTop) {
            body.css("padding-top", nav.outerHeight() + "px")
            body.addClass("fixedNav")
        } else {
            body.css("padding-top", 0)
            body.removeClass("fixedNav")
        }
    }
});