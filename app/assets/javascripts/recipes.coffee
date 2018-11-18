window.onload = ( ->
  if $("#recipe-name-display")
    $("#name-field").on("propertychange change click keyup input paste", -> $("#recipe-name-display").text($("#name-field").val()) )

  if $("#recipe-preview-image")
    defaultUnknownImage = $("#recipe-preview-image").attr("src")
    $("#imageurl-field").on("propertychange change click keyup input paste", -> $("#recipe-preview-image").attr("src", if $("#imageurl-field").val() then $("#imageurl-field").val() else defaultUnknownImage))

  if $("#preparation-time-label")
    $("#preparation-time-label").css("font-size", $("#mintime-field").height() + "px")
)
