import Html exposing (Html, button, div, text, br)
import Html.App as Html
import Html.Events exposing (onClick)


main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL
type alias Model = Int

model : Model
model =
  0


-- UPDATE

type Msg 
    = Increment 
    | Decrement 
    | Reset
    | Double
    | Halve

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    Reset ->
      0

    Double ->
      model * 2

    Halve ->
      model // 2

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    , br [] []
    , button 
        [ onClick Reset ] 
        [ text "Reset" ]
    , button 
        [ onClick Double ] 
        [ text "Double" ]
    , button 
        [ onClick Halve ] 
        [ text "Halve" ]
    ]