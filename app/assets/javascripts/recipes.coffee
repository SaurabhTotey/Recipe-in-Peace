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

  itemDeleterActions = [(event) -> $(this).closest("li").remove()]

  if $("#ingredients-list")
    newIngredientFieldTemplate = $("#ingredients-list").find("li").last().clone()
    ingredientsListPopulator = (event) ->
      if !$("#ingredients-list").find("input").toArray().some((inputField) -> inputField.value == "")
        addedItem = newIngredientFieldTemplate.clone()
        $("#ingredients-list").children().last().append(addedItem)
        addedItem.find("input").on("propertychange change click keyup input paste", ingredientsListPopulator)
        addedItem.find(".item-deleter").on("click", (event) -> self = this; itemDeleterActions.forEach((action) -> action.apply(self, [event])))
    $("#ingredients-list").find("input").on("propertychange change click keyup input paste", ingredientsListPopulator)
    itemDeleterActions.push(ingredientsListPopulator)

  $(".item-deleter").on("click", (event) -> self = this; itemDeleterActions.forEach((action) -> action.apply(self, [event])))
)
