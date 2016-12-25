module State exposing (update, initialize, subscriptions)

import Array exposing (Array)
import Types exposing (..)
import Persistence
import Converters


persist : Model -> ( Model, Cmd msg )
persist model =
    ( model, Persistence.save model )



--INITIALIZE


emptyBoard : GameState
emptyBoard =
    { next = X, spaces = Array.repeat 9 Empty }


initialModel : Model
initialModel =
    { currentGameState = emptyBoard, history = [] }


initialize : ( Model, Cmd msg )
initialize =
    ( initialModel, Cmd.none )



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Persistence.onNewModel Update



--UPDATE


nextPlay : SquareState -> SquareState
nextPlay currentPlay =
    case currentPlay of
        X ->
            O

        _ ->
            X


updateGameState : Msg -> GameState -> GameState
updateGameState msg gameState =
    case msg of
        Play index ->
            { gameState | spaces = Array.set index gameState.next gameState.spaces, next = nextPlay gameState.next }

        _ ->
            gameState


previousState : List GameState -> GameState
previousState history =
    let
        previousState =
            List.head history
    in
        case previousState of
            Just state ->
                state

            Nothing ->
                emptyBoard


previousHistory : List GameState -> List GameState
previousHistory history =
    let
        previousHistory =
            List.tail history
    in
        case previousHistory of
            Just remainingHistory ->
                remainingHistory

            Nothing ->
                []


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play index ->
            persist
                { model
                    | currentGameState = updateGameState msg model.currentGameState
                    , history = model.currentGameState :: model.history
                }

        Update newModel ->
            ( Converters.toModel newModel, Cmd.none )

        Reset ->
            persist initialModel

        Undo ->
            persist
                { model
                    | currentGameState = previousState model.history
                    , history = previousHistory model.history
                }
