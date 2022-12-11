-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql


module Api.Object.Todos_row exposing (..)

import Api.InputObject
import Api.Interface
import Api.Object
import Api.Scalar
import Api.ScalarCodecs
import Api.Union
import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.Internal.Encode as Encode exposing (Value)
import Graphql.Operation exposing (RootMutation, RootQuery, RootSubscription)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet exposing (SelectionSet)
import Json.Decode as Decode


{-| -}
rowid : SelectionSet (Maybe Int) Api.Object.Todos_row
rowid =
    Object.selectionForField "(Maybe Int)" "rowid" [] (Decode.int |> Decode.nullable)


{-| -}
title : SelectionSet String Api.Object.Todos_row
title =
    Object.selectionForField "String" "title" [] Decode.string


{-| -}
completed : SelectionSet (Maybe Bool) Api.Object.Todos_row
completed =
    Object.selectionForField "(Maybe Bool)" "completed" [] (Decode.bool |> Decode.nullable)