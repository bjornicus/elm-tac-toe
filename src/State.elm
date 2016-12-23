module State exposing (update, initialize, subscriptions)

import Array exposing (Array)
import Types exposing (..)
import Persistence exposing (save)


initialize : ( Model, Cmd msg )
initialize =
    let
        model =
            { next = X, spaces = Array.repeat 9 Empty }
    in
        ( model, save model )


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
        Persist ->
            ( model, save model )

        Play index ->
            ( { model | spaces = Array.set index model.next model.spaces, next = nextPlay model.next }
            , Cmd.none
            )

        Reset ->
            initialize
