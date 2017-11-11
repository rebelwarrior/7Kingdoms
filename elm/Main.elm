module Main exposing (..)

import Html exposing (..)
import Model
import View
import Update


main : Program Never Model.Model Model.Msg
main =
    Html.beginnerProgram
        { model = Model.model
        , view = View.view
        , update = Update.update
        }
