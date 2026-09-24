module Route exposing (..)

import Dict exposing (Dict)
import Route.Path
import Route.Query
import Url exposing (Url)


type alias Route params =
    { path : Route.Path.Path
    , params : params
    , query : Dict String String
    , hash : Maybe String
    , url : Url
    }


fromUrl : params -> Url -> Route params
fromUrl params url =
    { path = Route.Path.fromUrl url
    , params = params
    , url = url
    , hash = url.fragment
    , query = Route.Query.fromUrl url
    }
