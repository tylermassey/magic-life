module ChevronDownIcon exposing (chevronDown)

import Html exposing (Html)
import Html.Attributes exposing (width, height)
import Svg exposing (svg, path)
import Svg.Attributes exposing (viewBox, d, fill)


chevronDown : Html msg
chevronDown =
    svg
        [ width 48
        , height 48
        , viewBox "0 0 24 24"
        ]
        [ path
            [ fill "#D4E2E7"
            , d "M7.41,8.58L12,13.17L16.59,8.58L18,10L12,16L6,10L7.41,8.58Z"
            ]
            []
        ]
