// Generated by CoffeeScript 1.12.6
(function() {
  var APP;

  APP = void 0;

  APP = {};

  APP.AnimationsWaypoints = function() {
    var elements, elementsWaypoint;
    elements = $('body').find('[waypoint-devhero]');
    elementsWaypoint = [];
    console.log(elements);
    return $.each(elements, function(index, element) {
      var config, configRaw;
      configRaw = $(element).attr('waypoint-devhero');
      config = $.parseJSON(configRaw);
      return elementsWaypoint.push(new Waypoint({
        element: $(element),
        handler: function(direction) {
          $(this.element).css('animation-delay', config.delay + 's');
          $(this.element).addClass(config.type + ' ' + 'animate animate-start');
        },
        offset: config.offset + '%'
      }));
    });
  };

  APP.devHeroAnimate = function() {
    var animationElementArray;
    animationElementArray = $(document).find('[devhero-animate]');
    return $.each(animationElementArray, function(index, element) {
      var AnimationArea, WindowArea, checkIfIsInArea, checkPercentOfScrollArea, config, configRaw, direction, posTopOfElement, translateElement, windowHeight;
      configRaw = $(element).attr('devhero-animate');
      config = $.parseJSON(configRaw);
      if (config.direction == null) {
        config.direction = 'up';
      }
      if (config.range == null) {
        config.range = 50;
      }
      if (config.offset == null) {
        config.offset = 30;
      }
      if (config.direction === 'up') {
        direction = 1;
      } else if (config.direction === 'down') {
        direction = -1;
      }
      posTopOfElement = $(element).offset().top;
      windowHeight = $(window).height();
      $(window).resize(function() {
        return this.windowHeight = $(window).height();
      });
      AnimationArea = {};
      AnimationArea.posX = posTopOfElement - (windowHeight * (config.offset / 100));
      AnimationArea.posY = AnimationArea.posX + windowHeight;
      checkIfIsInArea = function(index, WindowAreaTop, WindowAreaBottom, AnimationAreaTop, AnimationAreaBottom, element, direction, range) {
        if ((WindowAreaTop < AnimationAreaTop && WindowAreaBottom < AnimationAreaTop) || (WindowAreaTop > AnimationAreaBottom && WindowAreaBottom > AnimationAreaBottom)) {
          return false;
        } else {
          return checkPercentOfScrollArea(index, element, AnimationAreaTop, WindowAreaBottom, direction, range);
        }
      };
      checkPercentOfScrollArea = function(index, element, AnimationAreaPosX, WindowAreaPosY, direction, range) {
        var percentView;
        percentView = (WindowAreaPosY - AnimationAreaPosX) / (2 * $(window).height());
        return translateElement(element, percentView, direction, range);
      };
      translateElement = function(element, percentView, direction, range) {
        return $(element).css('transform', 'translateY(' + (percentView * direction * range) + '%)');
      };
      $(window).scroll(function() {
        var WindowArea;
        WindowArea = {};
        WindowArea.posX = $(window).scrollTop();
        WindowArea.posY = WindowArea.posX + $(window).height();
        return checkIfIsInArea(index, WindowArea.posX, WindowArea.posY, AnimationArea.posX, AnimationArea.posY, element, direction, config.range);
      });
      WindowArea = {};
      WindowArea.posX = $(window).scrollTop();
      WindowArea.posY = WindowArea.posX + $(window).height();
      return checkIfIsInArea(index, WindowArea.posX, WindowArea.posY, AnimationArea.posX, AnimationArea.posY, element, direction, config.range);
    });
  };

  APP.init = function() {
    APP.devHeroAnimate();
    APP.AnimationsWaypoints();
  };

  $(document).ready(function() {
    APP.init();
  });

}).call(this);

//# sourceMappingURL=main.js.map
