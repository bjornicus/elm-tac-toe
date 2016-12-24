module State exposing (update, initialize, subscriptions)

import Array exposing (Array)
import Types exposing (..)
import Persistence


persist : Model -> ( Model, Cmd msg )
persist model =
    ( model, Persistence.save model )



--INITIALIZE


initialize : ( Model, Cmd msg )
initialize =
    persist { next = X, spaces = Array.repeat 9 Empty }



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


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Play index ->
            persist { model | spaces = Array.set index model.next model.spaces, next = nextPlay model.next }

        Update newModel ->
            ( Persistence.toModel newModel, Cmd.none )

        Reset ->
            initialize
