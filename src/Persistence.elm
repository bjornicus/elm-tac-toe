port module Persistence exposing (save)

import Array exposing (Array)
import Types exposing (Model)
import View exposing (squareStateToString)


type alias PortModel =
    { next : String
    , spaces : Array.Array String
    }


save : Model -> Cmd msg
save model =
    updateData <| PortModel (squareStateToString model.next) (Array.map squareStateToString model.spaces)


port updateData : PortModel -> Cmd msg



--port newValue : (String -> msg) -> Sub msg
--subscriptions : Model -> Sub Msg
--subscriptions model =
--    newValue Suggest
