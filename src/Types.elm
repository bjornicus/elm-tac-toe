module Types exposing (..)

import Array


type SquareState
    = X
    | O
    | Empty


type alias GameState =
    { next : SquareState
    , spaces : Array.Array SquareState
    }


type alias PortableGameState =
    { next : String
    , spaces : Array.Array String
    }


type alias Model =
    { currentGameState : GameState
    , history : List GameState
    }


type alias PortableModel =
    { currentGameState : PortableGameState
    , history : List PortableGameState
    }


type Msg
    = Play Int
    | Update PortableModel
    | Reset
    | Undo
