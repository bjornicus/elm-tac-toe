port module Persistence exposing (save, onNewModel, toModel)

import Array exposing (Array)
import Types exposing (..)


--type alias PortModel =
--    { next : String
--    , spaces : Array.Array String
--    }


toModel : PortModel -> Model
toModel portModel =
    Model (squareStateFromString portModel.next) (Array.map squareStateFromString portModel.spaces)


fromModel : Model -> PortModel
fromModel model =
    PortModel (squareStateToString model.next) (Array.map squareStateToString model.spaces)


save : Model -> Cmd msg
save model =
    updateData <| fromModel model


onNewModel : (PortModel -> msg) -> Sub msg
onNewModel =
    newModel


port updateData : PortModel -> Cmd msg


port newModel : (PortModel -> msg) -> Sub msg
