# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  canvas = document.getElementById("myCanvas");
  ctx = canvas.getContext("2d");

  drawCircle = (centerX, centerY, radius, color = 'black') ->
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);

    ctx.fillStyle = color;
    ctx.fill();
    ctx.stroke();
    return

  $('#myCanvas').click (e) ->
    radius = $('#radius').val()
    attempt = localStorage.getItem("attempt")
    attempt++
    rect = e.target.getBoundingClientRect()
    posX = e.clientX - (rect.left)
    posY = e.clientY - (rect.top)
    localStorage.setItem("posX" + attempt, posX);
    localStorage.setItem("posY" + attempt, posY);

    if attempt == 4
      color = '#00ff00'

    drawCircle(parseInt(posX), parseInt(posY), 2, color)
    console.log "drawCircle, attempt: " + attempt

    if attempt == 4
      console.log "attempt == 4"
      i = 1
      point_x = posX
      point_y = posY
      iteration = $('#iteration').val()
      window['a']
      while (i <= iteration)
        randomInt = Math.floor(Math.random() * 3) + 1
        point_x = point_x + (localStorage.getItem("posX" + randomInt) - point_x) / 2
        point_y = point_y + (localStorage.getItem("posY" + randomInt) - point_y) / 2
        drawCircle(point_x, point_y, radius, color)
        i++

    if attempt > 4
      console.log "attempt > 3"
      attempt = 0
      ctx.clearRect(0,0,canvas.width, canvas.height);
    localStorage.setItem("attempt", attempt);

