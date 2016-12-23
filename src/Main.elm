-- structure based on http://blog.jenkster.com/2016/04/how-i-structure-elm-apps.html


module Main exposing (main)

import Html
import Types exposing (Model, Msg)
import State
import View


main : Program Never Model Msg
main =
    Html.program
        { init = State.initialize
        , update = State.update
        , subscriptions = State.subscriptions
        , view = View.view
        }
