$.fn.twitter_bootstrap_confirmbox =
  defaults:
    fade: false
    title: null
    cancel: "Cancel"
    cancel_class: "btn cancel"
    proceed: "OK"
    proceed_class: "btn proceed btn-primary"

TwitterBootstrapConfirmBox = (message, element, callback) ->
  $(document.body).append(
    $(
      '<div class="modal hide" id="confirmation_dialog">
        <div class="modal-header"><button type="button" class="close" data-dismiss="modal">×</button><h3>...</h3></div>
        <div class="modal-body"></div>
        <div class="modal-footer"><a href="#" class="btn cancel" data-dismiss="modal">...</a><a href="#" class="btn proceed btn-primary">...</a></div>
      </div>'
    )
  )

  $("#confirmation_dialog").addClass("fade") if element.data("confirm-fade") || $.fn.twitter_bootstrap_confirmbox.defaults.fade
  $("#confirmation_dialog .modal-body").html(message.replace(/\n/g, "<br />"))
  $("#confirmation_dialog .modal-header h3").html(element.data("confirm-title") || $.fn.twitter_bootstrap_confirmbox.defaults.title || window.top.location.origin)
  $("#confirmation_dialog .modal-footer .cancel").html(element.data("confirm-cancel") || $.fn.twitter_bootstrap_confirmbox.defaults.cancel).attr("class", $.fn.twitter_bootstrap_confirmbox.defaults.cancel_class).addClass(element.data("confirm-cancel-class"))
  $("#confirmation_dialog .modal-footer .proceed").html(element.data("confirm-proceed") || $.fn.twitter_bootstrap_confirmbox.defaults.proceed).attr("class", $.fn.twitter_bootstrap_confirmbox.defaults.proceed_class).addClass(element.data("confirm-proceed-class"))
  $("#confirmation_dialog").modal("show").on("hidden", ->
    $(this).remove()
  )

  $("#confirmation_dialog .proceed").click (event) ->
    event.preventDefault()
    $("#confirmation_dialog").modal("hide")
    callback()
    false

  $("#confirmation_dialog .cancel").click (event) ->
    event.preventDefault()
    $("#confirmation_dialog").modal("hide")
    false

$.rails.allowAction = (element) ->
  message = element.data("confirm")
  answer = false
  return true unless message

  if $.rails.fire(element, "confirm")
    TwitterBootstrapConfirmBox message, element, ->
      if $.rails.fire(element, "confirm:complete", [answer])
        allowAction = $.rails.allowAction

        $.rails.allowAction = ->
          true
        
        if element.get(0).click
          element.get(0).click()
        else
          evt = new MouseEvents("click", {
            bubbles : true,
            cancelable : true,
            view : window,
            detail : 0,
            screenX : 0,
            screenY : 0,
            clientX : 0,
            clientY : 0,
            ctrlKey : false,
            altKey : false,
            shiftKey : false,
            metaKey : false,
            button : 0,
            relatedTarget : document.body.parentNode
          })
          element.get(0).dispatchEvent(evt)

        $.rails.allowAction = allowAction
  
  false
