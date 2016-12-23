module Types exposing (..)

import Array


squareStateToString : SquareState -> String
squareStateToString state =
    case state of
        X ->
            "X"

        O ->
            "O"

        Empty ->
            ""


squareStateFromString : String -> SquareState
squareStateFromString state =
    case state of
        "X" ->
            X

        "O" ->
            O

        _ ->
            Empty


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
    | Update Model
    | Reset
