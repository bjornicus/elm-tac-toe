port module Persistence exposing (save, newModelSubscription)

import Array exposing (Array)
import Types exposing (..)


save : Model -> Cmd msg
save model =
    updateData <| PortModel (squareStateToString model.next) (Array.map squareStateToString model.spaces)


newModelSubscription : Sub Msg
newModelSubscription =
    newModel toUpdateCommand


type alias PortModel =
    { next : String
    , spaces : Array.Array String
    }


port updateData : PortModel -> Cmd msg


port newModel : (PortModel -> msg) -> Sub msg


toUpdateCommand : PortModel -> msg
toUpdateCommand portModel =
    Update


toModel : PortModel -> Model
toModel portModel =
    Model (squareStateFromString portModel.next) (Array.map squareStateFromString portModel.spaces)
