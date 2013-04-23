require "../public/javascripts/init.js"

describe "TwitterBootstrapConfirm", ->
  beforeEach ->
    createDocument()
  
  it "should have fade set to false by default", ->
    expect($.fn.twitter_bootstrap_confirmbox.defaults.fade).toBe(false)

  it "should have not set a title by default", ->
    expect($.fn.twitter_bootstrap_confirmbox.defaults.title).toBe(null)

  it "should use 'Cancel' as a default cancel text", ->
    expect($.fn.twitter_bootstrap_confirmbox.defaults.cancel).toBe("Cancel")

  it "should use 'OK' as a default proceed text", ->
    expect($.fn.twitter_bootstrap_confirmbox.defaults.proceed).toBe("OK")

  it "should use 'btn proceed btn-primary' as a default class for the proceed button", ->
    expect($.fn.twitter_bootstrap_confirmbox.defaults.proceed_class).toBe("btn proceed btn-primary")
