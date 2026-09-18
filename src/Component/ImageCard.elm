module Component.ImageCard exposing (..)

import Html exposing (Html, figcaption, figure, img, text)
import Html.Attributes exposing (alt, class, src)


type ImageCard msg
    = Settings
        { caption : String
        , imageUrl : String
        }


new :
    { caption : String
    , imageUrl : String
    }
    -> ImageCard msg
new props =
    Settings
        { caption = props.caption
        , imageUrl = props.imageUrl
        }


view : ImageCard msg -> Html msg
view (Settings settings) =
    figure
        [ class "w-[250px] overflow-hidden rounded-base border-2 border-border bg-background font-base shadow-shadow" ]
        [ img
            [ class "w-full aspect-4/3"
            , src settings.imageUrl
            , alt "image"
            ]
            []
        , figcaption
            [ class "border-t-2 text-foreground border-border p-4" ]
            [ text settings.caption ]
        ]
