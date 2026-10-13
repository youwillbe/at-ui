module Core.View exposing (..)

import Browser exposing (Document)
import Html exposing (Html)


type alias View msg =
    { title : String
    , body : List (Html msg)
    }



-- 让 msg 的转换可以工作在包装类型 View 上
-- 也即让 View 成为 Functor


map : (msg1 -> msg2) -> View msg1 -> View msg2
map f view =
    { title = view.title
    , body = List.map (Html.map f) view.body
    }


toBrowserDocument : View msg -> Document msg
toBrowserDocument view =
    { title = view.title
    , body = view.body
    }
