module Utils.MaybeEx exposing (..)


toList : Maybe a -> List a
toList x =
    case x of
        Just v ->
            [ v ]

        Nothing ->
            []
