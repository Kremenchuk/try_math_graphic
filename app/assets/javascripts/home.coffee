# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->

  canvas = document.getElementById("myCanvas");
  ctx = canvas.getContext("2d");
  app_color = "rgba(0, 255, 0, 1)"

  drawCircle = (centerX, centerY, radius) ->
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);

    ctx.fillStyle = app_color;
    ctx.fill();
    ctx.stroke();
    return

  triangleFractal = (e, iteration) ->
    radius = $('#radius').val()
    attempt = localStorage.getItem("attempt")
    attempt++
    rect = e.target.getBoundingClientRect()
    posX = e.clientX - (rect.left)
    posY = e.clientY - (rect.top)
    localStorage.setItem("posX" + attempt, posX);
    localStorage.setItem("posY" + attempt, posY);

    drawCircle(parseInt(posX), parseInt(posY), 2)

    if attempt == 4
      i = 1
      point_x = posX
      point_y = posY

      while (i <= iteration)
        randomInt = Math.floor(Math.random() * 3) + 1
        point_x = point_x + (localStorage.getItem("posX" + randomInt) - point_x) / 2
        point_y = point_y + (localStorage.getItem("posY" + randomInt) - point_y) / 2
        drawCircle(point_x, point_y, radius, app_color)
        i++

    if attempt > 4
      attempt = 0
      ctx.clearRect(0,0,canvas.width, canvas.height);
    localStorage.setItem("attempt", attempt);
    return



  paporotFractal = (e, iterationCount) ->
    radius = $('#radius').val()

    p = undefined
    oldx = undefined
    r = 80
    x = 1.0
    y = 0.0
    while iterationCount > 0
      p = Math.random()
      oldx = x
      if p <= 0.85
        x = 0.85 * x + 0.04 * y
        y = -0.04 * oldx + 0.85 * y + 1.6
      else
        if p <= 0.92
          x = 0.25 * x - (0.26 * y)
          y = 0.23 * oldx + 0.25 * y + 1.6
        else if p <= 0.99
          x = -0.15 * x + 0.3 * y
          y = 0.26 * oldx + 0.2 * y + 0.44
        else
          x = 0.0
          y = 0.16 * y
      drawCircle(400 + Math.round(r * x), 850 - Math.round(r * y), radius)
      iterationCount--
    return


  #$('#myCanvas').click (e) ->
   # iteration = $('#iteration').val()
    #console.log $('#switch_model').val()
    #if parseInt($('#switch_model').val()) == 1
    #  console.log "triangleFractal"
    #  triangleFractal(e, iteration)
    #if parseInt($('#switch_model').val()) == 2
    #  console.log "paporotFractal"
    #  paporotFractal(e, iteration)
    #return

  $('#myCanvas').mouseup (event) ->
    switch event.which
      when 1
        console.log 'left'
        iteration = $('#iteration').val()
        console.log $('#switch_model').val()
        if parseInt($('#switch_model').val()) == 1
          console.log "triangleFractal"
          triangleFractal(event, iteration)
        if parseInt($('#switch_model').val()) == 2
          console.log "paporotFractal"
          paporotFractal(event, iteration)
      when 3
        console.log 'center'
        attempt = 0
        ctx.clearRect(0,0,canvas.width, canvas.height);
        localStorage.setItem("attempt", attempt);
    return


