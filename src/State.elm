module State exposing (update, initialize, subscriptions)

import Array exposing (Array)
import Types exposing (..)


initialize : ( Model, Cmd msg )
initialize =
    ( { next = X, spaces = Array.repeat 9 Empty }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


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
            ( { model | spaces = Array.set index model.next model.spaces, next = nextPlay model.next }
            , Cmd.none
            )
