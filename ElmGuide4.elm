import Html exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)


main = 
    Html.program { model = model, view = view, update = update }


-- MODEL
type alias Model =
    { dieFace : Int
    }


model : Model
model = 
    { dieFace = 0 }


-- UPDATE
type Msg = Roll


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Roll ->
            (model, Cmd.none)


-- VIEW
view : Model -> Html Msg
view model =
    div []
      [ h1 [] [ text (Basics.toString model.dieFace)]
      , button [ onClick Roll ] [ text "Roll" ] 
      ]


-- SUBSCRIPTIONS


-- INIT
init : (Model, Cmd Msg)
init =
    (Model 1, Cmd.none)