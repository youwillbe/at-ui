module Main.Pages.Model exposing (..)

import Pages.Home


type Model
    = Home Pages.Home.Model
    | NotFound
    | Redirecting
    | Loading
