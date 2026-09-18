module Component.Accordion exposing (..)

import Html exposing (Html, button, div, h3, text)


type alias Id =
    String


type alias Item =
    { id : Id
    , label : String
    , content : String
    }


type Accordion msg
    = Settings
        { items : List Item
        , opened : List Id
        }


new :
    { items : List Item
    }
    -> Accordion msg
new props =
    Settings
        { items = props.items
        , opened = []
        }


withDefaultOpened : List Id -> Accordion msg -> Accordion msg
withDefaultOpened opened (Settings settings) =
    Settings { settings | opened = opened }


view : Accordion msg -> Html msg
view (Settings settings) =
    div [] (List.map renderItem settings.items)


renderItem : Item -> Html msg
renderItem item =
    div []
        [ h3 []
            [ button []
                [ text item.label
                ]
            ]
        , div []
            [ div []
                [ text item.content
                ]
            ]
        ]
