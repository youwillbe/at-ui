module Main exposing (..)

import Browser
import Browser.Navigation
import Json.Decode
import Main.Layouts.Model
import Main.Pages.Model
import Route
import Shared
import Url exposing (Url)
import View exposing (View)


main : Program Json.Decode.Value Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = UrlRequest
        }



-- MODEL


type alias Model =
    { key : Browser.Navigation.Key
    , url : Url
    , page : Main.Pages.Model.Model
    , layout : Maybe Main.Layouts.Model.Model
    , shared : Shared.Model
    }


init : Json.Decode.Value -> Url -> Browser.Navigation.Key -> ( Model, Cmd Msg )
init json url key =
    let
        -- 1. 解析 flag
        flagResult =
            Json.Decode.decodeValue Shared.decoder json

        -- 2. 解析 url 为 Route
        route =
            Route.fromUrl () url

        -- 3. shared 有可能是存储后再还原回来的，所以初始化的时候需要 flag
        ( sharedModel, sharedEffect ) =
            Shared.init flagResult route

        page =
            Debug.todo "page"

        layout =
            Debug.todo "page"
    in
    ( { key = key
      , url = url
      , page = page
      , layout = layout
      , shared = sharedModel
      }
    , Cmd.none
    )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    pageView model


pageView : Model -> View Msg
pageView model =
    case model.page of
        Main.Pages.Model.Home ->
            Debug.todo "todo"

        Main.Pages.Model.NotFound ->
            Debug.todo "todo"

        Main.Pages.Model.Redirecting ->
            Debug.todo "todo"

        Main.Pages.Model.Loading ->
            Debug.todo "todo"



-- UPDATE


type Msg
    = UrlRequest Browser.UrlRequest
    | UrlChanged Url
    | Page
    | Layout
    | Shared
    | Batch (List Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Debug.todo "todo"


subscriptions : Model -> Sub Msg
subscriptions =
    Debug.todo "todo"
