module Component.Marker exposing
    ( Marker
    , Variant(..)
    , new
    , view
    , withIcon
    , withVariant
    )

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)


type Marker msg
    = Settings
        { icon : Maybe String
        , content : String
        , variant : Variant
        }


new : { content : String } -> Marker msg
new props =
    Settings
        { variant = Default
        , content = props.content
        , icon = Nothing
        }


type Variant
    = Default
    | Separator
    | Border


withVariant : Variant -> Marker msg -> Marker msg
withVariant variant (Settings settings) =
    Settings { settings | variant = variant }


withIcon : String -> Marker msg -> Marker msg
withIcon icon (Settings settings) =
    Settings { settings | icon = Just icon }


view : Marker msg -> Html msg
view (Settings settings) =
    div
        [ class "group/marker relative flex min-h-4 w-full items-center gap-2 text-left text-sm font-base text-foreground [&_svg:not([class*='size-'])]:size-4 [a]:underline [a]:underline-offset-3 [a]:hover:text-foreground"
        , class (variantClass settings.variant)
        ]
        ((case settings.icon of
            Just icon ->
                [ span
                    [ class icon
                    , class "size-4 shrink-0 [&_svg:not([class*='size-'])]:size-4"
                    ]
                    []
                ]

            Nothing ->
                []
         )
            ++ [ span
                    [ class "min-w-0 wrap-break-word group-data-[variant=separator]/marker:flex-none group-data-[variant=separator]/marker:text-center *:[a]:underline *:[a]:underline-offset-3 *:[a]:hover:text-foreground"
                    ]
                    [ text settings.content ]
               ]
        )


variantClass : Variant -> String
variantClass variant =
    case variant of
        Default ->
            ""

        Separator ->
            "before:mr-0 before:h-0.5 before:min-w-0 before:flex-1 before:bg-border after:ml-0 after:h-0.5 after:min-w-0 after:flex-1 after:bg-border"

        Border ->
            "border-b-2 border-border pb-2"
