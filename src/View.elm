module View exposing (view)

import Html exposing (beginnerProgram, div, button, text, br, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (style, class, placeholder)
import Array exposing (Array)
import Types exposing (..)
import Converters exposing (squareStateToString)


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


view : Model -> Html.Html Msg
view model =
    div []
        [ input [ placeholder "Game Code", onInput (RoomCode) ] []
        , button [ onClick (JoinGame) ] [ text "Join" ]
        , div [ class "board" ] <| row model.currentGameState.spaces
        , button [ onClick (Reset) ] [ text "reset" ]
        , button [ onClick (Undo) ] [ text "undo" ]
        ]
