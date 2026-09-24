module View exposing (..)

import Html exposing (Html)


type alias View msg =
    { title : String
    , body : List (Html msg)
    }
