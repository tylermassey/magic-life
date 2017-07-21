module Main exposing (..)

import Array exposing (Array, get, set)
import Array.Extra exposing (map2)
import Html exposing (Html, text, div, img, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onWithOptions)
import Json.Decode as Json
import Time exposing (Time, millisecond)
import Random
import ChevronDownIcon exposing (chevronDown)
import ChevronUpIcon exposing (chevronUp)
import D20Icon exposing (d20Icon)
import DieFaces exposing (viewDieFace)
import DiceIcon exposing (diceIcon)
import ResetIcon exposing (resetIcon)


---- MODEL ----


type PlayerView
    = ScoreView
    | DiceView


type alias PlayerRecord =
    { score : Int
    , dieValue : Int
    }


type alias Model =
    { playerView : PlayerView
    , playerRecords : Array PlayerRecord
    , diceRollsLeft : Int
    }


initialPlayerRecord : PlayerRecord
initialPlayerRecord =
    { score = 20
    , dieValue = 3
    }


initialModel : Model
initialModel =
    { playerView = ScoreView
    , playerRecords =
        Array.fromList
            [ initialPlayerRecord
            , initialPlayerRecord
            ]
    , diceRollsLeft = 4
    }


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



---- UPDATE ----


type Msg
    = PlayerRecords PlayerRecordsMsg
    | ResetScores
    | StartDiceRoll
    | RollSingleDie Time
    | GoToScoresView


type PlayerRecordsMsg
    = AddPoint Int
    | SubtractPoint Int
    | OnRollResult (List Int)


updatePlayerRecords : PlayerRecordsMsg -> Array PlayerRecord -> Array PlayerRecord
updatePlayerRecords playerRecordsMsg playerRecords =
    case playerRecordsMsg of
        AddPoint player ->
            let
                playerRecord =
                    Maybe.withDefault initialPlayerRecord (get player playerRecords)

                updatedPlayerRecord =
                    { playerRecord | score = playerRecord.score + 1 }
            in
                set player updatedPlayerRecord playerRecords

        SubtractPoint player ->
            let
                playerRecord =
                    Maybe.withDefault initialPlayerRecord (get player playerRecords)

                updatedPlayerRecord =
                    { playerRecord | score = playerRecord.score - 1 }
            in
                set player updatedPlayerRecord playerRecords

        OnRollResult dieValues ->
            map2 (\dv playerRecord -> { playerRecord | dieValue = dv }) (Array.fromList dieValues) playerRecords


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayerRecords msg ->
            ( { model | playerRecords = updatePlayerRecords msg model.playerRecords }
            , Cmd.none
            )

        StartDiceRoll ->
            ( { model
                | playerView = DiceView
                , diceRollsLeft = 5
              }
            , Cmd.none
            )

        RollSingleDie time ->
            ( { model
                | diceRollsLeft = model.diceRollsLeft - 1
              }
            , Cmd.map PlayerRecords (Random.generate OnRollResult (Random.list 2 (Random.int 1 6)))
            )

        GoToScoresView ->
            ( { model | playerView = ScoreView }
            , Cmd.none
            )

        ResetScores ->
            ( initialModel
            , Cmd.none
            )



---- SUBSCRIPTIONS ----


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.playerView == DiceView && model.diceRollsLeft > 0 then
        Time.every (400 * millisecond) RollSingleDie
    else
        Sub.none



---- VIEW ----


onClick : msg -> Html.Attribute msg
onClick message =
    onWithOptions "click" { stopPropagation = True, preventDefault = True } (Json.succeed message)


viewPlayerScore : number -> number -> Html PlayerRecordsMsg
viewPlayerScore score player =
    if player == 1 then
        div [ class "player-container" ]
            [ div [ class "player-score-container" ]
                [ div [ class "player-score-button button", onClick (SubtractPoint player) ] [ chevronDown ]
                , div [ class "player-score" ] [ text (toString score) ]
                , div [ class "player-score-button button", onClick (AddPoint player) ] [ chevronUp ]
                ]
            ]
    else
        div [ class "player-container" ]
            [ div [ class "player-score-container" ]
                [ div [ class "player-score-button button rotate", onClick (AddPoint player) ] [ chevronUp ]
                , div [ class "player-score rotate" ] [ text (toString score) ]
                , div [ class "player-score-button button rotate", onClick (SubtractPoint player) ] [ chevronDown ]
                ]
            ]


viewPlayerArea : Model -> Int -> Html Msg
viewPlayerArea model player =
    case model.playerView of
        ScoreView ->
            Html.map PlayerRecords
                (viewPlayerScore
                    (get player model.playerRecords
                        |> Maybe.map .score
                        |> Maybe.withDefault 20
                    )
                    player
                )

        DiceView ->
            viewDieFace
                (get player model.playerRecords
                    |> Maybe.map .dieValue
                    |> Maybe.withDefault 0
                )


viewResetOrScoresOption : Model -> Html Msg
viewResetOrScoresOption model =
    if model.playerView /= DiceView then
        div [ onClick ResetScores ] [ resetIcon ]
    else
        div [ onClick GoToScoresView ] [ d20Icon ]


view : Model -> Html Msg
view model =
    div [ class "app-container" ]
        [ viewPlayerArea model 0
        , div [ class "options-container" ]
            [ viewResetOrScoresOption model
            , div [ onClick StartDiceRoll ] [ diceIcon ]
            ]
        , viewPlayerArea model 1
        ]



---- PROGRAM ----


main : Program Never Model Msg
main =
    Html.program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
