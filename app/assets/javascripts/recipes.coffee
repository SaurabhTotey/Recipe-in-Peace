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
    newIngredientListItemTemplate = $("#ingredients-list").find("li").last().clone()
    ingredientsListPopulator = (event) ->
      if !$("#ingredients-list").find("input").toArray().some((inputField) -> inputField.value == "")
        addedItem = newIngredientListItemTemplate.clone()
        $("#ingredients-list").children().last().append(addedItem)
        addedItem.find("input").on("propertychange change click keyup input paste", ingredientsListPopulator)
        addedItem.find(".item-deleter").on("click", (event) -> self = this; itemDeleterActions.forEach((action) -> action.apply(self, [event])))
    $("#ingredients-list").find("input").on("propertychange change click keyup input paste", ingredientsListPopulator)
    itemDeleterActions.push(ingredientsListPopulator)

  if $("#steps-list")
    newIngredientListItemTemplate = $("#steps-list").find("li").last().clone()
    stepsListPopulator = (event) ->
      if !$("#steps-list").find("input").toArray().some((inputField) -> inputField.value == "")
        addedItem = newIngredientListItemTemplate.clone()
        $("#steps-list").children().last().append(addedItem)
        addedItem.find("input").on("propertychange change click keyup input paste", stepsListPopulator)
        addedItem.find(".item-deleter").on("click", (event) -> self = this; itemDeleterActions.forEach((action) -> action.apply(self, [event])))
    $("#steps-list").find("input").on("propertychange change click keyup input paste", stepsListPopulator)
    itemDeleterActions.push(stepsListPopulator)

  $(".item-deleter").on("click", (event) -> self = this; itemDeleterActions.forEach((action) -> action.apply(self, [event])))

  if $(".form-submit")
    method = if $(".form-submit").find("button").first().text() == "Add Recipe" then "POST" else "PUT"
    formatArray = (arrayToFormat) -> "{" + arrayToFormat.toString() + "}"
    $(".form-submit").find("button").first().on("click", ->
      formInformation = {
        name: $("#name-field").val(),
        imageURL: $("#imageurl-field").val(),
        description: $("#description-field").val(),
        ingredients: formatArray($("#ingredients-list").find("input").toArray().map((input) -> input.value).filter((value) -> value != "")),
        steps: formatArray($("#steps-list").find("input").toArray().map((input) -> input.value).filter((value) -> value != "")),
        utensils: formatArray($("#utensils-list").find(".selected-utensil").toArray().map((utensilButton) -> utensilButton.innerText)),
        minTime: $("#mintime-field").val(),
        maxTime: $("#maxtime-field").val(),
        password: $("#password-field").val()
      }
      fetch(window.location.href.split("/").slice(0, -1).join("/"), {
        method: method,
        headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'), 'Content-Type': 'application/json', 'Accept': 'application/json' }
        body: JSON.stringify({ recipe: formInformation })
      }).then((response) ->
        console.log(response)
        if response.ok
          window.location.href = "/"
        else
          # TODO alert user of incorrect password
      )
    )

  if $("#delete-button")
    $("#delete-button").on("click", ->
      fetch(window.location.href.split("/").slice(0, -1).join("/"), {
        method: "DELETE",
        headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'), 'Content-Type': 'application/json', 'Accept': 'application/json' }
        body: JSON.stringify({ recipe: { password: $("#password-field").val() } })
      }).then((response) ->
        console.log(response)
        if response.ok
          window.location.href = "/"
        else
          # TODO alert user of incorrect password
      )
    )
)
