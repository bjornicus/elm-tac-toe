-- structure based on http://blog.jenkster.com/2016/04/how-i-structure-elm-apps.html


module Main exposing (main)

import Html exposing (beginnerProgram, div, button, text, br)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, class)
import Array exposing (Array)


main =
    beginnerProgram { model = { next = X, spaces = Array.repeat 9 Empty }, view = view, update = update }


squareStateToString state =
    case state of
        X ->
            "X"

        O ->
            "O"

        Empty ->
            ""


squareElement index squareState =
    div
        [ onClick (Play index)
        , class "space"
        ]
        [ text <| squareStateToString squareState ]


row squares =
    Array.toList <| Array.indexedMap squareElement squares


view model =
    div [ class "board" ] <| row model.spaces


type SquareState
    = X
    | O
    | Empty


type alias Model =
    { next : SquareState
    , spaces : Array SquareState
    }


type Msg
    = Play Int


nextPlay currentPlay =
    case currentPlay of
        X ->
            O

        _ ->
            X


update msg model =
    case msg of
        Play index ->
            { model | spaces = Array.set index model.next model.spaces, next = nextPlay model.next }
