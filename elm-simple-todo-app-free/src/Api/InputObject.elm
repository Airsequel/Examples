-- Do not manually edit this file, it was auto-generated by dillonkearns/elm-graphql
-- https://github.com/dillonkearns/elm-graphql
module Api.InputObject exposing (..)


import Graphql.Internal.Builder.Argument as Argument exposing (Argument)
import Graphql.Internal.Builder.Object as Object
import Graphql.SelectionSet exposing (SelectionSet)
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Api.Object
import Api.Interface
import Api.Union
import Api.Scalar
import Api.ScalarCodecs
import Json.Decode as Decode
import Graphql.Internal.Encode as Encode exposing (Value)




buildBooleanComparison : (BooleanComparisonOptionalFields -> BooleanComparisonOptionalFields)
 -> BooleanComparison
buildBooleanComparison fillOptionals____ =

    let
        optionals____ =
            
            fillOptionals____
                { eq = Absent }
    in
    { eq = optionals____.eq }


type alias BooleanComparisonOptionalFields =
    { eq : (OptionalArgument Bool) }


{-| Type for the BooleanComparison input object.
-}
type alias BooleanComparison =
    { eq : (OptionalArgument Bool) }
    

{-| Encode a BooleanComparison into a value that can be used as an argument.
-}
encodeBooleanComparison : BooleanComparison -> Value
encodeBooleanComparison input____ =
    Encode.maybeObject
        [ ( "eq", (Encode.bool)  |> Encode.optional input____.eq ) ]


buildFloatComparison : (FloatComparisonOptionalFields -> FloatComparisonOptionalFields)
 -> FloatComparison
buildFloatComparison fillOptionals____ =

    let
        optionals____ =
            
            fillOptionals____
                { eq = Absent }
    in
    { eq = optionals____.eq }


type alias FloatComparisonOptionalFields =
    { eq : (OptionalArgument Float) }


{-| Type for the FloatComparison input object.
-}
type alias FloatComparison =
    { eq : (OptionalArgument Float) }
    

{-| Encode a FloatComparison into a value that can be used as an argument.
-}
encodeFloatComparison : FloatComparison -> Value
encodeFloatComparison input____ =
    Encode.maybeObject
        [ ( "eq", (Encode.float)  |> Encode.optional input____.eq ) ]


buildIntComparison : (IntComparisonOptionalFields -> IntComparisonOptionalFields)
 -> IntComparison
buildIntComparison fillOptionals____ =

    let
        optionals____ =
            
            fillOptionals____
                { eq = Absent }
    in
    { eq = optionals____.eq }


type alias IntComparisonOptionalFields =
    { eq : (OptionalArgument Int) }


{-| Type for the IntComparison input object.
-}
type alias IntComparison =
    { eq : (OptionalArgument Int) }
    

{-| Encode a IntComparison into a value that can be used as an argument.
-}
encodeIntComparison : IntComparison -> Value
encodeIntComparison input____ =
    Encode.maybeObject
        [ ( "eq", (Encode.int)  |> Encode.optional input____.eq ) ]


buildStringComparison : (StringComparisonOptionalFields -> StringComparisonOptionalFields)
 -> StringComparison
buildStringComparison fillOptionals____ =

    let
        optionals____ =
            
            fillOptionals____
                { eq = Absent }
    in
    { eq = optionals____.eq }


type alias StringComparisonOptionalFields =
    { eq : (OptionalArgument String) }


{-| Type for the StringComparison input object.
-}
type alias StringComparison =
    { eq : (OptionalArgument String) }
    

{-| Encode a StringComparison into a value that can be used as an argument.
-}
encodeStringComparison : StringComparison -> Value
encodeStringComparison input____ =
    Encode.maybeObject
        [ ( "eq", (Encode.string)  |> Encode.optional input____.eq ) ]


buildTodos_filter : (Todos_filterOptionalFields -> Todos_filterOptionalFields)
 -> Todos_filter
buildTodos_filter fillOptionals____ =

    let
        optionals____ =
            
            fillOptionals____
                { rowid = Absent, title = Absent, completed = Absent }
    in
    { rowid = optionals____.rowid, title = optionals____.title, completed = optionals____.completed }


type alias Todos_filterOptionalFields =
    { rowid : (OptionalArgument IntComparison)
 , title : (OptionalArgument StringComparison)
 , completed : (OptionalArgument StringComparison) }


{-| Type for the Todos_filter input object.
-}
type alias Todos_filter =
    { rowid : (OptionalArgument IntComparison)
 , title : (OptionalArgument StringComparison)
 , completed : (OptionalArgument StringComparison) }
    

{-| Encode a Todos_filter into a value that can be used as an argument.
-}
encodeTodos_filter : Todos_filter -> Value
encodeTodos_filter input____ =
    Encode.maybeObject
        [ ( "rowid", (encodeIntComparison)  |> Encode.optional input____.rowid ), ( "title", (encodeStringComparison)  |> Encode.optional input____.title ), ( "completed", (encodeStringComparison)  |> Encode.optional input____.completed ) ]


buildTodos_insert_input : (Todos_insert_inputOptionalFields -> Todos_insert_inputOptionalFields)
 -> Todos_insert_input
buildTodos_insert_input fillOptionals____ =

    let
        optionals____ =
            
            fillOptionals____
                { rowid = Absent, title = Absent, completed = Absent }
    in
    { rowid = optionals____.rowid, title = optionals____.title, completed = optionals____.completed }


type alias Todos_insert_inputOptionalFields =
    { rowid : (OptionalArgument Int)
 , title : (OptionalArgument String)
 , completed : (OptionalArgument String) }


{-| Type for the Todos_insert_input input object.
-}
type alias Todos_insert_input =
    { rowid : (OptionalArgument Int)
 , title : (OptionalArgument String)
 , completed : (OptionalArgument String) }
    

{-| Encode a Todos_insert_input into a value that can be used as an argument.
-}
encodeTodos_insert_input : Todos_insert_input -> Value
encodeTodos_insert_input input____ =
    Encode.maybeObject
        [ ( "rowid", (Encode.int)  |> Encode.optional input____.rowid ), ( "title", (Encode.string)  |> Encode.optional input____.title ), ( "completed", (Encode.string)  |> Encode.optional input____.completed ) ]


buildTodos_set_input : (Todos_set_inputOptionalFields -> Todos_set_inputOptionalFields)
 -> Todos_set_input
buildTodos_set_input fillOptionals____ =

    let
        optionals____ =
            
            fillOptionals____
                { rowid = Absent, title = Absent, completed = Absent }
    in
    { rowid = optionals____.rowid, title = optionals____.title, completed = optionals____.completed }


type alias Todos_set_inputOptionalFields =
    { rowid : (OptionalArgument Int)
 , title : (OptionalArgument String)
 , completed : (OptionalArgument String) }


{-| Type for the Todos_set_input input object.
-}
type alias Todos_set_input =
    { rowid : (OptionalArgument Int)
 , title : (OptionalArgument String)
 , completed : (OptionalArgument String) }
    

{-| Encode a Todos_set_input into a value that can be used as an argument.
-}
encodeTodos_set_input : Todos_set_input -> Value
encodeTodos_set_input input____ =
    Encode.maybeObject
        [ ( "rowid", (Encode.int)  |> Encode.optional input____.rowid ), ( "title", (Encode.string)  |> Encode.optional input____.title ), ( "completed", (Encode.string)  |> Encode.optional input____.completed ) ]
