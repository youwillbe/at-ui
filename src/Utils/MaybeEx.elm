module Utils.MaybeEx exposing (..)


toList : Maybe a -> List a
toList x =
    case x of
        Just v ->
            [ v ]

        Nothing ->
            []


maybeCons : Maybe a -> List a -> List a
maybeCons maybe l =
    case maybe of
        Just m ->
            m :: l

        Nothing ->
            l
