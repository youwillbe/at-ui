module Component.Dropdown exposing
    ( Dropdown
    , Model
    , Msg
    , Size(..)
    , init
    , new
    , outTrigger
    , update
    , view
    , withCustomTrigger
    , withDisabled
    , withOnChange
    , withSizeSmall
    , withTriggerLabel
    )

import Component.Button as Button
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Task



-- SETTINGS


type Dropdown item msg
    = Settings
        { model : Model item
        , toMsg : Msg item msg -> msg
        , choices : List item
        , toLabel : item -> String
        , size : Size
        , isDisabled : Bool
        , onChange : Maybe (item -> msg)
        , triggerLabel : String
        , customTrigger : Maybe (Html msg)
        }


new :
    { model : Model item
    , toMsg : Msg item msg -> msg
    , choices : List item
    , toLabel : item -> String
    }
    -> Dropdown item msg
new props =
    Settings
        { model = props.model
        , toMsg = props.toMsg
        , choices = props.choices
        , toLabel = props.toLabel
        , size = Normal
        , isDisabled = False
        , onChange = Nothing
        , triggerLabel = "Dropdown"
        , customTrigger = Nothing
        }



-- MODEL


type Model item
    = Model
        { selected : Maybe item
        , search : String
        , isMenuOpen : Bool
        }


init : { selected : Maybe item } -> Model item
init props =
    Model
        { selected = props.selected
        , search = ""
        , isMenuOpen = False
        }



-- MODIFIERS


type Size
    = Normal
    | Small


withSizeSmall : Dropdown item msg -> Dropdown item msg
withSizeSmall (Settings settings) =
    Settings { settings | size = Small }


withDisabled : Dropdown item msg -> Dropdown item msg
withDisabled (Settings settings) =
    Settings { settings | isDisabled = True }


withOnChange :
    (item -> msg)
    -> Dropdown item msg
    -> Dropdown item msg
withOnChange onChange (Settings settings) =
    Settings { settings | onChange = Just onChange }


withTriggerLabel : String -> Dropdown item msg -> Dropdown item msg
withTriggerLabel label (Settings settings) =
    Settings { settings | triggerLabel = label }


withCustomTrigger : Html msg -> Dropdown item msg -> Dropdown item msg
withCustomTrigger t (Settings settings) =
    Settings { settings | customTrigger = Just t }



-- UPDATE


outTrigger : Msg item msg
outTrigger =
    Triggered


type Msg item msg
    = Triggered
    | SelectedItem
        { item : item
        , onChange : Maybe msg
        }


update :
    { msg : Msg item msg
    , model : Model item
    , toModel : Model item -> model
    , toMsg : Msg item msg -> msg
    }
    -> ( model, Cmd msg )
update props =
    let
        (Model model) =
            props.model

        toParentModel : ( Model item, Cmd msg ) -> ( model, Cmd msg )
        toParentModel ( innerModel, effect ) =
            ( props.toModel innerModel
            , effect
            )
    in
    toParentModel <|
        case props.msg of
            Triggered ->
                ( Model { model | isMenuOpen = True }
                , Cmd.none
                )

            SelectedItem data ->
                ( Model
                    { model
                        | search = ""
                        , isMenuOpen = False
                        , selected = Just data.item
                    }
                , case data.onChange of
                    Just onChange ->
                        onChange
                            |> Task.succeed
                            |> Task.perform identity

                    Nothing ->
                        Cmd.none
                )



-- VIEW


view : Dropdown item msg -> Html msg
view (Settings settings) =
    let
        (Model model) =
            settings.model

        viewDropdownMenu : Html msg
        viewDropdownMenu =
            if model.isMenuOpen then
                div [ class "isolate z-50 outline-none" ]
                    [ div [ class "z-50 min-w-[8rem] overflow-hidden rounded-base border-2 border-border bg-background p-1 font-base text-foreground outline-none origin-(--transform-origin) data-open:animate-in data-closed:animate-out data-closed:fade-out-0 data-open:fade-in-0 data-closed:zoom-out-95 data-open:zoom-in-95 data-[side=bottom]:slide-in-from-top-2 data-[side=left]:slide-in-from-right-2 data-[side=right]:slide-in-from-left-2 data-[side=top]:slide-in-from-bottom-2 data-[side=inline-end]:slide-in-from-left-2 data-[side=inline-start]:slide-in-from-right-2" ]
                        (div [ class "px-2 py-1.5 text-sm font-heading data-inset:pl-8" ] [ text settings.triggerLabel ]
                            :: List.map viewDropdownMenuItem settings.choices
                        )
                    ]

            else
                text ""

        viewDropdownMenuItem : item -> Html msg
        viewDropdownMenuItem item =
            button
                [ class "relative gap-2 [&_svg]:pointer-events-none [&_svg]:w-4 [&_svg]:h-4 [&_svg]:shrink-0 flex cursor-default select-none items-center rounded-base border-2 border-transparent data-inset:pl-8 px-2 py-1.5 text-sm font-base outline-hidden transition-colors hover:bg-main hover:text-main-foreground hover:border-border focus:bg-main focus:text-main-foreground focus:border-border data-highlighted:bg-main data-highlighted:text-main-foreground data-highlighted:border-border data-disabled:pointer-events-none data-disabled:opacity-50"
                , onClick (onMenuItemClick item)
                ]
                [ text (settings.toLabel item)
                ]

        onMenuItemClick : item -> msg
        onMenuItemClick item =
            settings.toMsg <|
                case settings.onChange of
                    Just onChange ->
                        SelectedItem
                            { item = item
                            , onChange = Just (onChange item)
                            }

                    Nothing ->
                        SelectedItem
                            { item = item
                            , onChange = Nothing
                            }

        rendertrigger : Html msg
        rendertrigger =
            case settings.customTrigger of
                Just t ->
                    t

                Nothing ->
                    Button.new { label = settings.triggerLabel }
                        |> Button.withOnClick (settings.toMsg Triggered)
                        |> Button.view
    in
    div [] [ rendertrigger, viewDropdownMenu ]
