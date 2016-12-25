module Converters exposing (..)

import Types exposing (..)
import Array exposing (Array)


toModel : PortableModel -> Model
toModel portableModel =
    Model (toGameState portableModel.currentGameState) (List.map toGameState portableModel.history)


fromModel : Model -> PortableModel
fromModel model =
    PortableModel (toPortableGameState model.currentGameState) (List.map toPortableGameState model.history)


toGameState : PortableGameState -> GameState
toGameState portableGameState =
    GameState (squareStateFromString portableGameState.next) (Array.map squareStateFromString portableGameState.spaces)


toPortableGameState : GameState -> PortableGameState
toPortableGameState gameState =
    PortableGameState (squareStateToString gameState.next) (Array.map squareStateToString gameState.spaces)


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
