module View exposing (view)

import Html exposing (beginnerProgram, div, button, text, br)
import Html.Events exposing (onClick)
import Html.Attributes exposing (style, class)
import Array exposing (Array)
import Types exposing (..)


squareStateToString : SquareState -> String
squareStateToString state =
    case state of
        X ->
            "X"

        O ->
            "O"

        Empty ->
            ""


squareElement : Int -> SquareState -> Html.Html Msg
squareElement index squareState =
    div
        [ onClick (Play index)
        , class "space"
        ]
        [ text <| squareStateToString squareState ]


row : Array SquareState -> List (Html.Html Msg)
row squares =
    Array.toList <| Array.indexedMap squareElement squares


view : { a | spaces : Array SquareState } -> Html.Html Msg
view model =
    div [ class "board" ] <| row model.spaces