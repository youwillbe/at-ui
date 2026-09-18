module Main exposing (..)

import Component.Button as Button
import Component.ImageCard as ImageCard
import Html exposing (Html, div, span)
import Html.Attributes exposing (class)


main : Html msg
main =
    div [ class "h-screen w-screen grid place-items-center" ]
        [ div []
            [ testButton
            , ImageCard.new
                { caption = "Image"
                , imageUrl = "https://hips.hearstapps.com/hmg-prod/images/flowers-trees-and-bushes-reach-their-peak-of-full-bloom-in-news-photo-1678292967.jpg?resize=300:*"
                }
                |> ImageCard.view
            ]
        ]


testButton : Html msg
testButton =
    Button.new { label = "" }
        |> Button.withVariant Button.Neutral
        |> Button.withSize Button.Icon
        |> Button.withIcon (icon "iconify lucide--upload text-xl")
        |> Button.view


icon : String -> Html msg
icon name =
    span [ class name ] []
