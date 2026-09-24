module Page exposing (..)

import Effect exposing (Effect)
import Route exposing (Route)
import View exposing (View)


type Page model msg
    = Page
        { init : () -> ( model, Effect msg )
        , update : msg -> model -> ( model, Effect msg )
        , subscriptions : model -> Sub msg
        , view : model -> View msg
        , onUrlChanged : Maybe ({ from : Route (), to : Route () } -> msg)
        }


new :
    { init : () -> ( model, Effect msg )
    , update : msg -> model -> ( model, Effect msg )
    , subscriptions : model -> Sub msg
    , view : model -> View msg
    }
    -> Page model msg
new options =
    Page
        { init = options.init
        , update = options.update
        , subscriptions = options.subscriptions
        , view = options.view
        , onUrlChanged = Nothing
        }


withOnUrlChanged :
    ({ from : Route ()
     , to : Route ()
     }
     -> msg
    )
    -> Page model msg
    -> Page model msg
withOnUrlChanged onChange (Page page) =
    Page { page | onUrlChanged = Just onChange }
