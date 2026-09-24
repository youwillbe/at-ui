module Page.Home exposing (..)

import Animal exposing (Animal)
import Browser
import Component.Button as Button
import Component.Dropdown as Dropdown
import Component.ImageCard as ImageCard
import Component.Marker as Marker
import Html exposing (Html, div, span)
import Html.Attributes exposing (class)


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


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


type alias Model =
    { dropdown : Dropdown.Model Animal
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( { dropdown = Dropdown.init { selected = Nothing }
      }
    , Cmd.none
    )


type Msg
    = DropdownSent (Dropdown.Msg Animal Msg)
    | ChangedSelection Animal


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DropdownSent innerMsg ->
            Dropdown.update
                { msg = innerMsg
                , model = model.dropdown
                , toModel = \dropdown -> { model | dropdown = dropdown }
                , toMsg = DropdownSent
                }

        ChangedSelection _ ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> Html Msg
view model =
    div [ class "h-screen w-screen grid place-items-center" ]
        [ div [ class "space-y-4" ]
            [ testButton
            , ImageCard.new
                { caption = "Image"
                , imageUrl = "https://hips.hearstapps.com/hmg-prod/images/flowers-trees-and-bushes-reach-their-peak-of-full-bloom-in-news-photo-1678292967.jpg?resize=300:*"
                }
                |> ImageCard.view
            , Marker.new { content = "Searched the web" }
                |> Marker.withIcon "iconify lucide--globe"
                |> Marker.view
            , Dropdown.new
                { model = model.dropdown
                , toMsg = DropdownSent
                , choices = Animal.list
                , toLabel = Animal.toName
                }
                |> Dropdown.withOnChange ChangedSelection
                |> Dropdown.withTriggerLabel "点我"
                |> Dropdown.view
            ]
        ]
