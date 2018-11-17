window.onload = ( ->
  if $("#recipe-name-display")
    $("#name-field").on("propertychange change click keyup input paste", -> $("#recipe-name-display").text($("#name-field").val()) )
)