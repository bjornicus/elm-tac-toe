port module Persistence exposing (save, onNewModel, joinGame)

import Types exposing (..)
import Converters exposing (fromModel)


save : Model -> Cmd msg
save model =
    updateData <| fromModel model


onNewModel : (PortableModel -> msg) -> Sub msg
onNewModel =
    newModel


port joinGame : String -> Cmd msg


port updateData : PortableModel -> Cmd msg


port newModel : (PortableModel -> msg) -> Sub msg
