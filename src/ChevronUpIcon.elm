module ChevronUpIcon exposing (chevronUp)

import Html exposing (Html)
import Html.Attributes exposing (width, height)
import Svg exposing (svg, path)
import Svg.Attributes exposing (viewBox, d, fill)


chevronUp : Html msg
chevronUp =
    svg
        [ width 48
        , height 48
        , viewBox "0 0 24 24"
        ]
        [ path
            [ fill "#D4E2E7"
            , d "M7.41,15.41L12,10.83L16.59,15.41L18,14L12,8L6,14L7.41,15.41Z"
            ]
            []
        ]
