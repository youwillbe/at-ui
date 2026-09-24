module Route.Query exposing (..)

import Dict exposing (Dict)
import Url exposing (Url)


fromUrl : Url -> Dict String String
fromUrl url =
    case url.query of
        Nothing ->
            Dict.empty

        Just query ->
            if String.isEmpty query then
                Dict.empty

            else
                query
                    |> String.split "&"
                    |> List.filterMap (String.split "=" >> queryPiecesToTuple)
                    |> Dict.fromList


queryPiecesToTuple : List String -> Maybe ( String, String )
queryPiecesToTuple pieces =
    case pieces of
        [] ->
            Nothing

        key :: [] ->
            Just ( decodeQueryToken key, "" )

        key :: value :: _ ->
            Just ( decodeQueryToken key, decodeQueryToken value )


decodeQueryToken : String -> String
decodeQueryToken val =
    Url.percentDecode val
        |> Maybe.withDefault val
