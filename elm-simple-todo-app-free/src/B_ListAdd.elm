module B_ListAdd exposing (..)

import Api.Mutation as Mutation
import Api.Object exposing (Todos_row)
import Api.Object.Todos_mutation_response
import Api.Object.Todos_row as Todos_row
import Api.Query as Query
import Api.Scalar exposing (Id(..))
import Browser
import Graphql.Http
import Graphql.OptionalArgument exposing (OptionalArgument(..))
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Html exposing (div, form, h1, input, p, span, text)
import Html.Attributes exposing (checked, disabled, style, type_, value)
import Html.Events exposing (onInput, onSubmit)
import Json.Decode
import List exposing (map)
import Maybe exposing (withDefault)
import RemoteData exposing (RemoteData(..))


dbId : String
dbId =
    "01gfkrx7cw0tq8ahgyjdry1pk8"


graphqlApiUrl : String
graphqlApiUrl =
    "https://www.airsequel.com/dbs/" ++ dbId ++ "/graphql"


type alias TodoItem =
    { rowid : Maybe Int
    , title : Maybe String
    , completed : Maybe String
    }


type Msg
    = GotTasksResponse
        (RemoteData
            (Graphql.Http.Error (List TodoItem))
            (List TodoItem)
        )
    | NewTask String
    | AddTask
    | InsertAffectedRowsResponse (RemoteData (Graphql.Http.Error Int) Int)


type alias Model =
    { remoteTodos :
        RemoteData
            (Graphql.Http.Error (List TodoItem))
            (List TodoItem)
    , newTask : String
    , submissionStatus : RemoteData (Graphql.Http.Error Int) Int
    }


type alias Flags =
    ()


viewError : Graphql.Http.Error a -> Html.Html Msg
viewError error =
    case error of
        Graphql.Http.GraphqlError _ graphqlErrors ->
            div []
                (graphqlErrors
                    |> List.map (\gqlError -> p [] [ text gqlError.message ])
                )

        Graphql.Http.HttpError httpError ->
            case httpError of
                Graphql.Http.BadUrl url ->
                    p [] [ text <| "Bad URL: " ++ url ]

                Graphql.Http.BadStatus response body ->
                    p []
                        [ text <|
                            "Bad status (code "
                                ++ String.fromInt response.statusCode
                                ++ "): "
                                ++ body
                        ]

                Graphql.Http.NetworkError ->
                    p [] [ text <| "Network error" ]

                Graphql.Http.Timeout ->
                    p [] [ text "Timeout" ]

                Graphql.Http.BadPayload response ->
                    p []
                        [ text <|
                            "Bad payload: "
                                ++ Json.Decode.errorToString response
                        ]


viewTodo : TodoItem -> Html.Html Msg
viewTodo todo =
    p []
        [ input
            [ type_ "checkbox"
            , checked
                (case todo.completed of
                    Nothing ->
                        False

                    Just "false" ->
                        False

                    Just "true" ->
                        True

                    Just _ ->
                        False
                )
            , disabled True
            ]
            []
        , span [] [ text <| withDefault "" todo.title ]
        ]


view : Model -> Browser.Document Msg
view model =
    { title = "Todo App"
    , body =
        [ div
            [ style "font-family" "sans-serif"
            , style "max-width" "20em"
            , style "margin" "0 auto"
            ]
            [ h1 [] [ text "Todos" ]
            , case model.remoteTodos of
                NotAsked ->
                    p [] [ text "Initializing …" ]

                Loading ->
                    p [] [ text "Loading …" ]

                Success todos ->
                    div [] (todos |> map viewTodo)

                Failure error ->
                    viewError error
            , let
                inputForm =
                    form [ onSubmit AddTask ]
                        [ input
                            [ type_ "text"
                            , onInput NewTask
                            , value model.newTask
                            ]
                            []
                        , input
                            [ type_ "submit"
                            , if model.newTask == "" then
                                disabled True

                              else
                                disabled False
                            ]
                            []
                        ]
              in
              case model.submissionStatus of
                NotAsked ->
                    inputForm

                Loading ->
                    p [] [ text "Submitting …" ]

                Failure error ->
                    viewError error

                Success _ ->
                    inputForm
            ]
        ]
    }


todosSelection : SelectionSet TodoItem Todos_row
todosSelection =
    SelectionSet.map3 TodoItem
        Todos_row.rowid
        Todos_row.title
        Todos_row.completed


getTodos : Cmd Msg
getTodos =
    Query.todos identity todosSelection
        |> Graphql.Http.queryRequest graphqlApiUrl
        |> Graphql.Http.send (RemoteData.fromResult >> GotTasksResponse)


insertTodo : String -> Cmd Msg
insertTodo title =
    Mutation.insert_todos
        { objects =
            [ { rowid = Null
              , title = Present title
              , completed = Present "false"
              }
            ]
        }
        Api.Object.Todos_mutation_response.affected_rows
        |> Graphql.Http.mutationRequest graphqlApiUrl
        |> Graphql.Http.send
            (RemoteData.fromResult >> InsertAffectedRowsResponse)


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { remoteTodos = RemoteData.Loading
      , newTask = ""
      , submissionStatus = RemoteData.NotAsked
      }
    , getTodos
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotTasksResponse response ->
            ( { model | remoteTodos = response }, Cmd.none )

        AddTask ->
            ( { model | submissionStatus = RemoteData.Loading }
            , if model.newTask /= "" then
                insertTodo model.newTask

              else
                Cmd.none
            )

        NewTask title ->
            ( { model | newTask = title }, Cmd.none )

        InsertAffectedRowsResponse response ->
            ( { model
                | remoteTodos =
                    RemoteData.map
                        (\todos ->
                            todos
                                ++ [ { rowid = Nothing
                                     , title = Just "Loading …"
                                     , completed = Nothing
                                     }
                                   ]
                        )
                        model.remoteTodos
                , submissionStatus = response
              }
            , getTodos
            )


main : Platform.Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
