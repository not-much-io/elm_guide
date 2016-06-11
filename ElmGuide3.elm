import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String
import Char

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age : Int
  , err_msg : String
  }


model : Model
model =
  {-- Initialization of a Model type --}
  Model "" "" "" 0 ""


-- UPDATE

type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Validate


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Age age ->
      let
        result = 
          Result.withDefault 0 (String.toInt age)
      in
        { model | age = result }

    Validate ->
      { model | err_msg = 
        if (validationLogic model) then
          ""
        else 
          "Password must contain.."
      }

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "Password", placeholder "Password", onInput Password ] []
    , input [ type' "Password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , input [ type' "Number", placeholder "Age", onInput Age ] []
    , input [ type' "Button", value "Submit", onClick Validate ] [ ]
    , text model.err_msg
    , div [] [ (getModelDebugInfo model) ]
    ]

getModelDebugInfo : Model -> Html msg
getModelDebugInfo model =
  div [] 
  [ br [] []
  , div [] [ (text "Name:")
           , br [] []
           , (text model.name) 
           ]
  , div [] [ (text "Password:")
           , br [] []
           , (text model.password) 
           ]
  , div [] [ (text "PasswordAgain:")
           , br [] []
           , (text model.passwordAgain) 
           ]
  , div [] [ (text "Age:")
           , br [] []
           , (text (toString model.age)) 
           ]
  ]

validationLogic : Model -> Bool
validationLogic model =
    let
      validity =
         List.all Basics.identity 
         [ model.password == model.passwordAgain
         , String.length model.password >= 8
         , String.any Char.isUpper model.password
         , String.any Char.isLower model.password
         , String.any Char.isDigit model.password
         ]
    in
      validity

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if (validationLogic model) then
        ("green", "OK")
      else
        ("red", "Not a valid password!")
  in
    div [ style [("color", color)] ] [ text message ]
