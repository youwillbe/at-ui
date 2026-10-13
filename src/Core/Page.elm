module Core.Page exposing (Page, init, new, subscriptions, update, view)

import Core.View exposing (View)
import Effect exposing (Effect)



-- 惯用法，不透明类型，不暴露构造函数


type Page model msg
    = Page
        { init : () -> ( model, Effect msg )
        , update : msg -> model -> ( model, Effect msg )
        , subscriptions : model -> Sub msg
        , view : model -> View msg
        }



-- new 是唯一构造 Page 的方式


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
        }



-- 下面的函数用于快速解包


init : Page model msg -> ( model, Effect msg )
init (Page page) =
    page.init ()


update : Page model msg -> msg -> model -> ( model, Effect msg )
update (Page page) =
    page.update


subscriptions : Page model msg -> model -> Sub msg
subscriptions (Page page) =
    page.subscriptions


view : Page model msg -> model -> View msg
view (Page page) =
    page.view
