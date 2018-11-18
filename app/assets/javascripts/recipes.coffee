window.onload = ( ->
  if $("#recipe-name-display")
    nameDisplayAction = -> $("#recipe-name-display").text($("#name-field").val())
    nameDisplayAction()
    $("#name-field").on("propertychange change click keyup input paste", nameDisplayAction )

  if $("#recipe-preview-image")
    defaultUnknownImage = $("#recipe-preview-image").attr("src")
    recipePreviewImageAction = -> $("#recipe-preview-image").attr("src", if $("#imageurl-field").val() then $("#imageurl-field").val() else defaultUnknownImage)
    recipePreviewImageAction()
    $("#imageurl-field").on("propertychange change click keyup input paste", recipePreviewImageAction )

  if $("#preparation-time-label")
    $("#preparation-time-label").css("font-size", $("#mintime-field").height() + "px")

  if $("#utensils-list")
    buttonIds = ["fork", "spoon", "knife", "hands"].map((utensil) -> "#" + utensil + "-selection-button")
    buttonIds.forEach((id) -> $(id).on("click", (event) -> $(id).toggleClass("selected-utensil")))
)
