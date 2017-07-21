module ResetIcon exposing (resetIcon)

import Html exposing (Html)
import Html.Attributes exposing (width, height)
import Svg exposing (svg, path)
import Svg.Attributes exposing (viewBox, d, fill)


resetIcon : Html msg
resetIcon =
    svg
        [ width 48
        , height 48
        , viewBox "0 0 24 24"
        ]
        [ path
            [ fill "#A5BCC5"
            , d "M17.65,6.35C16.2,4.9 14.21,4 12,4A8,8 0 0,0 4,12A8,8 0 0,0 12,20C15.73,20 18.84,17.45 19.73,14H17.65C16.83,16.33 14.61,18 12,18A6,6 0 0,1 6,12A6,6 0 0,1 12,6C13.66,6 15.14,6.69 16.22,7.78L13,11H20V4L17.65,6.35Z"
            ]
            []
        ]