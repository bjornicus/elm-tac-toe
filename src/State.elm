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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play index ->
            persist { model | currentGameState = updateGameState msg model.currentGameState }

        Update newModel ->
            ( Converters.toModel newModel, Cmd.none )

        Reset ->
            persist initialModel
