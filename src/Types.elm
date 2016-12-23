module Types exposing (..)

import Array


type SquareState
    = X
    | O
    | Empty


type alias Model =
    { next : SquareState
    , spaces : Array.Array SquareState
    }


type Msg
    = Play Int
    | Reset
