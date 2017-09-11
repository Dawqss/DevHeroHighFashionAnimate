APP = undefined

APP = {}


APP.AnimationsWaypoints = ->
  elements = $('body').find('[waypoint-devhero]')

  elementsWaypoint = []

  $.each elements, (index, element) ->
    configRaw = $(element).attr('waypoint-devhero')
    config = $.parseJSON(configRaw)
    elementsWaypoint.push(new Waypoint(
      element: $(element)
      handler: (direction) ->
        $(this.element).css('animation-delay', config.delay + 's')
        $(this.element).addClass(config.type + ' ' + 'animate animate-start')
        return
      offset: config.offset + '%'
    ))

APP.devHeroAnimate = ->
  animationElementArray = $(document).find('[devhero-animate]')
  $.each animationElementArray, (index, element) ->

    configRaw = $(element).attr('devhero-animate')
    config = $.parseJSON(configRaw)

    if !config.direction?
      config.direction = 'up'
    if !config.range?
      config.range = 50
    if !config.offset?
      config.offset = 30
    if config.direction == 'up'
      direction = 1
    else if config.direction == 'down'
      direction = -1

    posTopOfElement = $(element).offset().top

    windowHeight = $(window).height()

    $(window).resize ->
      this.windowHeight = $(window).height()

    AnimationArea = {}
    AnimationArea.posX = posTopOfElement - (windowHeight * (config.offset / 100))
    AnimationArea.posY = AnimationArea.posX + windowHeight


    checkIfIsInArea = (index, WindowAreaTop, WindowAreaBottom, AnimationAreaTop, AnimationAreaBottom, element, direction, range) ->
      if(WindowAreaTop < AnimationAreaTop && WindowAreaBottom < AnimationAreaTop) || (WindowAreaTop > AnimationAreaBottom && WindowAreaBottom > AnimationAreaBottom)
        return false
      else
        checkPercentOfScrollArea(index, element, AnimationAreaTop, WindowAreaBottom, direction, range)

    checkPercentOfScrollArea = (index, element, AnimationAreaPosX, WindowAreaPosY, direction, range) ->
      percentView = (WindowAreaPosY - AnimationAreaPosX) / (2 * $(window).height())
      translateElement(element, percentView, direction, range)

    translateElement = (element, percentView, direction, range) ->
      $(element).css('transform', 'translateY(' + (percentView * direction * range) + '%)')

    $(window).scroll ->
      WindowArea = {}
      WindowArea.posX = $(window).scrollTop()
      WindowArea.posY = WindowArea.posX + $(window).height()
      console.log(windowHeight)
      checkIfIsInArea(index, WindowArea.posX, WindowArea.posY, AnimationArea.posX, AnimationArea.posY, element, direction, config.range)

    WindowArea = {}
    WindowArea.posX = $(window).scrollTop()
    WindowArea.posY = WindowArea.posX + $(window).height()
    console.log()
    checkIfIsInArea(index, WindowArea.posX, WindowArea.posY, AnimationArea.posX, AnimationArea.posY, element, direction, config.range)

APP.init = ->
  APP.devHeroAnimate()
  APP.AnimationsWaypoints()
  return

$(document).ready ->
  APP.init()
  return
