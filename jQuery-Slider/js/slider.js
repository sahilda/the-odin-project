sliderInt = 1;
sliderNext = 2;

$(document).ready(function() {
	$("#slider > img#1").fadeIn(300);
	startSlider();

});

function startSlider() {
		count = $("#slider > img").size();

		function loop() {
			$("#slider > img").fadeOut(300);
			$("#slider > img#" + sliderNext).fadeIn(300);

			sliderInt = sliderNext;
			sliderNext = sliderNext + 1;

			if(sliderNext > count) {
			sliderNext = 1;
			}
		}

		interval = setInterval(loop, 3000);

		$("img").hover(function() {
			clearInterval(interval);
			$("p").fadeIn(0);
		}, function() {
			interval = setInterval(loop, 3000);
			$("p").fadeOut(0);
		});


		$("a.left").click(function() {
			clearInterval(interval);

			sliderNext = sliderInt - 1;
			if(sliderInt == 1) {
				sliderNext = 4;	
			}

			$("#slider > img").fadeOut(300);
			$("#slider > img#" + sliderNext).fadeIn(300);

			sliderInt = sliderNext;
			sliderNext = sliderNext + 1;

			if(sliderNext > count) {
			sliderNext = 1;
			}

			interval = setInterval(loop, 3000);
		});


		$("a.right").click(function() {
			clearInterval(interval);

			sliderNext = sliderInt + 1;
			if(sliderInt == 4) {
				sliderNext = 1;	
			}

			$("#slider > img").fadeOut(300);
			$("#slider > img#" + sliderNext).fadeIn(300);

			sliderInt = sliderNext;
			sliderNext = sliderNext + 1;

			if(sliderNext > count) {
			sliderNext = 1;
			}

			interval = setInterval(loop, 3000);
		});

	};