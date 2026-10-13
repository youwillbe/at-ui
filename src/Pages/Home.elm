module Pages.Home exposing (Model, Msg, page)

import Animal exposing (Animal)
import Component.Button as Button
import Component.Dropdown as Dropdown
import Component.ImageCard as ImageCard
import Component.Marker as Marker
import Effect exposing (Effect)
import Html exposing (Html, div, span)
import Html.Attributes exposing (class)
import Page exposing (Page)
import Route exposing (Route)
import View exposing (View)


page : () -> Route () -> Page Model Msg
page _ route =
    Page.new
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
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


init : () -> ( Model, Effect Msg )
init _ =
    ( { dropdown = Dropdown.init { selected = Nothing }
      }
    , Effect.none
    )


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Effect.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


view : Model -> View Msg
view model =
    { title = ""
    , body =
        [ div [ class "h-screen w-screen grid place-items-center" ]
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
                ]
            ]
        ]
    }
