updateCountdown = ->
  remaining = 80 - jQuery("#problem_content").val().length
  jQuery(".countdown").text remaining + " символов"
  jQuery(".countdown").css "color", (if (80 >= remaining >= 1) then "#526273")
  jQuery(".countdown").css "color", (if (0 >= remaining)  then "#B94A48")

jQuery ->
  updateCountdown()
  $("#problem_content").change updateCountdown
  $("#problem_content").keyup updateCountdown
