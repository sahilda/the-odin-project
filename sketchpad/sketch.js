$(document).ready(function() {
    make_grid(20);
    change_color_random();

    $("#random").click(function(){
        var squares=prompt("How many squares (1-128)?",20);
        $("#grid").empty();
        make_grid(squares);
        change_color_random();
    });

    $("#black").click(function(){
        var squares=prompt("How many squares (1-128)?",20);
        $("#grid").empty();
        make_grid(squares);
        change_color_black();
    });

    $("#grey").click(function(){
        var squares=prompt("How many squares (1-128)?",20);
        $("#grid").empty();
        make_grid(squares);
        change_color_darker();
    });

    $("#trailer").click(function(){
        var squares=prompt("How many squares (1-128)?",20);
        $("#grid").empty();
        make_grid(squares);
        change_color_trailer();
    });
});

function make_grid(squares) {
    i = 1;
    j = 1;
    side = Math.floor(Math.sqrt((960*960) / (squares * squares)));

    while(i <= squares) {
        $("#grid").append('<div class="column' + i +'" style="display:inline-block;" >');
        while(j <= squares) {
            $(".column" + i).append('<div class="square" style="width:' + side +'px; height:' + side + 'px">');
            j += 1;
        }
        i += 1;
        j = 1;
    }
    
};

function change_color_random() {
    $(".square").hover(function() {
        color1 = (Math.floor(Math.random() * 256));
        color2 = (Math.floor(Math.random() * 256));
        color3 = (Math.floor(Math.random() * 256));
        $(this).css("background-color","rgb("+ color1 + "," + color2 + "," + color3 + ")") ;
    });
};

function change_color_black() {
    $(".square").hover(function() {
        $(this).css("background-color","black") ;
    });
};

function change_color_darker() {
    $(".square").hover(function() {
        opc = parseFloat($(this).css("opacity"));

        if(opc == 1) {
            $(this).css("opacity","0.3");
        } else if (opc > .8) {
            $(this).css("opacity","0.99");
        } else {
            opc += 0.2; 
            $(this).css("opacity",opc);
        }

        $(this).css("background-color","black");
    }, function() {
        
    });
};

function change_color_trailer() {
    $(".square").hover(function() {
        $(this).css("background-color","black");
    }, function() {
        $(this).css("opacity","0.1");
        $(this).css("background-color","#E8E8E8");
        $(this).animate({"opacity": "1"}, 'slow');
    })
}

