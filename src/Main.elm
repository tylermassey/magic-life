module Main exposing (..)

import Html exposing (Html, text, div, img, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onWithOptions)
import Json.Decode as Json


---- MODEL ----


type alias Model =
    { playerOneScore : Int
    , playerTwoScore : Int
    }


initialModel : Model
initialModel =
    { playerOneScore = 20
    , playerTwoScore = 20
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = AddPointForPlayerOne
    | AddPointForPlayerTwo
    | SubtractPointForPlayerOne
    | SubtractPointForPlayerTwo
    | ResetScores


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AddPointForPlayerOne ->
            ( { model | playerOneScore = model.playerOneScore + 1 }, Cmd.none )

        AddPointForPlayerTwo ->
            ( { model | playerTwoScore = model.playerTwoScore + 1 }, Cmd.none )

        SubtractPointForPlayerOne ->
            ( { model | playerOneScore = model.playerOneScore - 1 }, Cmd.none )

        SubtractPointForPlayerTwo ->
            ( { model | playerTwoScore = model.playerTwoScore - 1 }, Cmd.none )

        ResetScores ->
            ( initialModel, Cmd.none )



---- VIEW ----


onClick : msg -> Html.Attribute msg
onClick message =
    onWithOptions "click" { stopPropagation = True, preventDefault = True } (Json.succeed message)


view : Model -> Html Msg
view model =
    div [ class "app-container" ]
        [ div [ class "player-container" ]
            [ div [ class "player-score-container" ]
                [ div [ class "player-score-button button", onClick SubtractPointForPlayerOne ] [ text "-" ]
                , div [ class "player-score" ] [ text (toString model.playerOneScore) ]
                , div [ class "player-score-button button", onClick AddPointForPlayerOne ] [ text "+" ]
                ]
            ]
        , div [ class "options-container" ]
            [ div [ class "reset-button button", onClick ResetScores ] [ text "Reset" ] ]
        , div [ class "player-container" ]
            [ div [ class "player-score-container" ]
                [ div [ class "player-score-button button", onClick AddPointForPlayerTwo ] [ text "+" ]
                , div [ class "player-score rotate" ] [ text (toString model.playerTwoScore) ]
                , div [ class "player-score-button button", onClick SubtractPointForPlayerTwo ] [ text "-" ]
                ]
            ]
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = always Sub.none
        }
