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

  triangleFractal = (iteration) ->
    console.log "IN triangleFractal"
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
    return



  paporotFractal = (iterationCount) ->
    console.log "IN paporotFractal"
    radius = $('#radius').val()
    color =
      r: 54
      g: 163
      b: 116
      a: 255
    # цвет папоротника


    ctx.putImageData imgData, 0, 0
    # количество итераций
    p = undefined
    oldx = undefined
    r = 80
    # коэффициент размера
    # координаты точки
    x = 1.0
    y = 0.0
    while iterationCount > 0
      p = Math.random()
      # генерируем случайное число от 0 до 1 (вероятность)
      oldx = x
      # запоминаем старое значение х
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
      # ставим пиксель, сдвигаем его в центр
      drawCircle(400 + Math.round(r * x), 850 - Math.round(r * y), radius, color)
      iterationCount--
    return


  $('#myCanvas').click (e) ->
    iteration = $('#iteration').val()
    console.log $('#switch_model').val()
    if $('#switch_model').val() == 1
      console.log "triangleFractal"
      triangleFractal(iteration)
    else
      console.log "paporotFractal"
      paporotFractal(iteration)





