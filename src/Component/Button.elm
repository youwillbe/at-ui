module Component.Button exposing
    ( Button
    , Size(..)
    , Variant(..)
    , new
    , view
    , withIcon
    , withOnClick
    , withSize
    , withVariant
    )

import Html exposing (Html, button, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Utils.MaybeEx as MaybeEx


type Button msg
    = Settings
        { label : String
        , variant : Variant
        , size : Size
        , icon : Maybe (Html msg)
        , onClick : Maybe msg
        }


type Variant
    = Default
    | NoShadow
    | Neutral
    | Reverse


type Size
    = DefaultSize
    | Xs
    | Sm
    | Lg
    | Icon
    | IconXs
    | IconSm
    | IconLg


new : { label : String } -> Button msg
new props =
    Settings
        { label = props.label
        , variant = Default
        , size = DefaultSize
        , icon = Nothing
        , onClick = Nothing
        }


withVariant : Variant -> Button msg -> Button msg
withVariant variant (Settings settings) =
    Settings { settings | variant = variant }


withSize : Size -> Button msg -> Button msg
withSize size (Settings settings) =
    Settings { settings | size = size }


withIcon : Html msg -> Button msg -> Button msg
withIcon icon (Settings settings) =
    Settings { settings | icon = Just icon }


withOnClick : msg -> Button msg -> Button msg
withOnClick msg (Settings settings) =
    Settings { settings | onClick = Just msg }


baseClass : String
baseClass =
    [ "cursor-pointer inline-flex items-center justify-center whitespace-nowrap"
    , "rounded-base text-sm font-base ring-offset-white transition-all gap-2"
    , "data-disabled:pointer-events-none data-disabled:opacity-50"
    , "disabled:pointer-events-none disabled:opacity-50"
    , "[&_svg]:pointer-events-none [&_svg]:size-4 [&_svg]:shrink-0"
    , "focus-visible:outline-hidden focus-visible:ring-2"
    , "focus-visible:ring-black focus-visible:ring-offset-2"
    ]
        |> String.join " "


variantClass : Variant -> String
variantClass variant =
    case variant of
        Default ->
            [ "text-main-foreground bg-main border-2 border-border"
            , "shadow-shadow hover:shadow-none"
            , "hover:translate-x-boxShadowX hover:translate-y-boxShadowY"
            ]
                |> String.join " "

        NoShadow ->
            "text-main-foreground bg-main border-2 border-border"

        Neutral ->
            [ "bg-secondary-background text-foreground border-2 border-border"
            , "shadow-shadow hover:shadow-none"
            , "hover:translate-x-boxShadowX hover:translate-y-boxShadowY"
            ]
                |> String.join " "

        Reverse ->
            [ "text-main-foreground bg-main border-2 border-border"
            , "hover:translate-x-reverseBoxShadowX hover:translate-y-reverseBoxShadowY"
            , "hover:shadow-shadow"
            ]
                |> String.join " "


sizeClass : Size -> String
sizeClass size =
    case size of
        DefaultSize ->
            "h-10 px-4 py-2"

        Xs ->
            "h-8 gap-1.5 px-2.5 text-xs [&_svg]:size-3.5"

        Sm ->
            "h-9 px-3"

        Lg ->
            "h-11 px-8"

        Icon ->
            "size-10"

        IconXs ->
            "size-8 [&_svg]:size-3.5"

        IconSm ->
            "size-9"

        IconLg ->
            "size-11"


view : Button msg -> Html msg
view (Settings settings) =
    button
        ([ class baseClass
         , class <| variantClass settings.variant
         , class <| sizeClass settings.size
         ]
            |> MaybeEx.maybeCons (Maybe.map onClick settings.onClick)
        )
        ([ text settings.label ]
            |> MaybeEx.maybeCons settings.icon
        )
