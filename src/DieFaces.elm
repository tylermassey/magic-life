module DieFaces exposing (viewDieFace)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)


one : Html msg
one =
    div [ class "face first-face" ]
        [ span [ class "pip" ] []
        ]


two : Html msg
two =
    div [ class "face second-face" ]
        [ span [ class "pip" ] []
        , span [ class "pip" ] []
        ]


three : Html msg
three =
    div [ class "face third-face" ]
        [ span [ class "pip" ] []
        , span [ class "pip" ] []
        , span [ class "pip" ] []
        ]


four : Html msg
four =
    div [ class "face fourth-face" ]
        [ div [ class "column" ]
            [ span [ class "pip" ] []
            , span [ class "pip" ] []
            ]
        , div [ class "column" ]
            [ span [ class "pip" ] []
            , span [ class "pip" ] []
            ]
        ]


five : Html msg
five =
    div [ class "face fifth-face" ]
        [ div [ class "column" ]
            [ span [ class "pip" ] []
            , span [ class "pip" ] []
            ]
        , div [ class "column" ]
            [ span [ class "pip" ] []
            ]
        , div [ class "column" ]
            [ span [ class "pip" ] []
            , span [ class "pip" ] []
            ]
        ]


six : Html msg
six =
    div [ class "face fourth-face" ]
        [ div [ class "column" ]
            [ span [ class "pip" ] []
            , span [ class "pip" ] []
            , span [ class "pip" ] []
            ]
        , div [ class "column" ]
            [ span [ class "pip" ] []
            , span [ class "pip" ] []
            , span [ class "pip" ] []
            ]
        ]


viewDieFace : Int -> Html msg
viewDieFace number =
    case number of
        1 ->
            one

        2 ->
            two

        3 ->
            three

        4 ->
            four

        5 ->
            five

        6 ->
            six

        _ ->
            div [] [ text (toString number) ]
