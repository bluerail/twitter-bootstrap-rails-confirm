$.fn.twitter_bootstrap_confirmbox =
  defaults:
    title: null
    proceed: "OK"
    proceed_class: "btn proceed"
    cancel: "Cancel"
    cancel_class: "btn cancel"
    fade: false

TwitterBootstrapConfirmBox = (message, element, callback) ->
  $dialog = $('
    <div class="modal hide" id="confirmation_dialog">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">×</button>
        <h3>...</h3>
      </div>
      <div class="modal-body"></div>
      <div class="modal-footer"></div>
    </div>
  ')

  $dialog.addClass("fade") if element.data("confirm-fade") || $.fn.twitter_bootstrap_confirmbox.defaults.fade

  $dialog
    .find(".modal-header")
      .find("h3")
        .html(element.data("confirm-title") || $.fn.twitter_bootstrap_confirmbox.defaults.title || window.top.location.origin)
      .end()
    .end()

    .find(".modal-body")
      .html(message.replace(/\n/g, "<br />"))
    .end()

    .find(".modal-footer")
      .append(
        $("<a />", {href: "#", "data-dismiss": "modal"})
          .html(element.data("confirm-cancel") || $.fn.twitter_bootstrap_confirmbox.defaults.cancel)
          .addClass($.fn.twitter_bootstrap_confirmbox.defaults.cancel_class)
          .addClass(element.data("confirm-cancel-class"))
          .click((event) ->
            event.preventDefault()
            $dialog.modal("hide")
          )
        ,
        $("<a />", {href: "#"})
          .html(element.data("confirm-proceed") || $.fn.twitter_bootstrap_confirmbox.defaults.proceed)
          .addClass($.fn.twitter_bootstrap_confirmbox.defaults.proceed_class)
          .addClass(element.data("confirm-proceed-class") || "btn-primary")
          .click((event) ->
            event.preventDefault()
            $dialog.modal("hide")
            callback()
          )
      )
    .end()

    .on("hidden", -> $(this).remove())

    .modal("show")

    .appendTo(document.body)

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
          
        else if MouseEvent?
          evt = new MouseEvent("click", {
            bubbles: true,
            cancelable: true,
            view: window,
            detail: 0,
            screenX: 0,
            screenY: 0,
            clientX: 0,
            clientY: 0,
            ctrlKey: false,
            altKey: false,
            shiftKey: false,
            metaKey: false,
            button: 0,
            relatedTarget: document.body.parentNode
          })
          element.get(0).dispatchEvent(evt)

        else if $.isFunction(document.createEvent)
          evt = document.createEvent "MouseEvents"
          evt.initMouseEvent(
            "click",
            true,   # e.bubbles,
            true,   # e.cancelable,
            window, # e.view,
            0,      # e.detail,
            0,      # e.screenX,
            0,      # e.screenY,
            0,      # e.clientX,
            0,      # e.clientY,
            false,  # e.ctrlKey,
            false,  # e.altKey,
            false,  # e.shiftKey,
            false,  # e.metaKey,
            0,      # e.button,
            document.body.parentNode # e.relatedTarget
          )
          element.get(0).dispatchEvent(evt)

        $.rails.allowAction = allowAction
  
  false
