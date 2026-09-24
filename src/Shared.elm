module Shared exposing (..)

import Effect exposing (Effect)
import Json.Decode
import Route exposing (Route)
import Shared.Model
import Shared.Msg


type alias Flags =
    {}


decoder : Json.Decode.Decoder Flags
decoder =
    Json.Decode.succeed {}


type alias Model =
    Shared.Model.Model


{-| 用 `flags` 和 `route` 来初始化 `shared`

`flags` 和 `shared` 不一定相同

-}
init : Result Json.Decode.Error Flags -> Route () -> ( Model, Effect Msg )
init flagsResult route =
    ( {}, Effect.None )


type alias Msg =
    Shared.Msg.Msg
