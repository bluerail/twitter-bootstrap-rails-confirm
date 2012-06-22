$(window).load ->
  TwitterBootstrapConfirmBox = (message, element, callback) ->
    $(document.body).append($('
      <div class="modal hide" id="confirmation_dialog">
        <div class="modal-header"><button type="button" class="close" data-dismiss="modal">×</button><h3>...</h3></div>
        <div class="modal-body"></div>
        <div class="modal-footer"><a href="#" class="btn cancel" data-dismiss="modal">...</a><a href="#" class="btn proceed btn-primary">...</a></div>
      </div>
    '))

    $("#confirmation_dialog .modal-body").html(message)
    $("#confirmation_dialog .modal-header h3").html(element.data("confirm-title") || window.top.location.origin)
    $("#confirmation_dialog .modal-footer .cancel").html(element.data("confirm-cancel") || "Cancel")
    $("#confirmation_dialog .modal-footer .proceed").html(element.data("confirm-proceed") || "Ok").attr("class", "btn proceed btn-primary").addClass(element.data("confirm-proceed-class"))
    $("#confirmation_dialog").modal "show"

    $("#confirmation_dialog .proceed").click ->
      $("#confirmation_dialog").modal("hide").remove()
      callback()
      true

    $("#confirmation_dialog .cancel").click ->
      $("#confirmation_dialog").modal("hide").remove()
      false

  $.rails.allowAction = (element) ->
    message = element.data("confirm")
    answer = false
    return true unless message

    if $.rails.fire(element, "confirm")
      TwitterBootstrapConfirmBox message, element, ->
        #callback = $.rails.fire(element, "confirm:complete", [answer])
        if $.rails.fire(element, "confirm:complete", [answer])
          allowAction = $.rails.allowAction

          $.rails.allowAction = ->
            true
          element.trigger "click"

          $.rails.allowAction = allowAction
    
    false