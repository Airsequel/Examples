module A_List exposing (..)

import Api.Object exposing (Todos_row)
import Api.Object.Todos_row as Todos_row
import Api.Query as Query
import Api.Scalar exposing (Id(..))
import Browser
import Graphql.Http
import Graphql.SelectionSet as SelectionSet exposing (SelectionSet)
import Html exposing (div, h1, input, p, span, text)
import Html.Attributes exposing (checked, disabled, style, type_)
import Json.Decode
import List exposing (map)
import RemoteData exposing (RemoteData(..))


dbId : String
dbId =
    "01gfpa0wn8pekcm60ysb7m5bp5"


graphqlApiUrl : String
graphqlApiUrl =
    "https://airsequel.fly.dev/dbs/" ++ dbId ++ "/graphql"


type alias TodoItem =
    { rowid : Maybe Int
    , title : String
    , completed : Maybe Bool
    }


type Msg
    = GotTasksResponse
        (RemoteData
            (Graphql.Http.Error (List TodoItem))
            (List TodoItem)
        )


type alias Model =
    { remoteTodos :
        RemoteData
            (Graphql.Http.Error (List TodoItem))
            (List TodoItem)
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
                    Just True ->
                        True

                    _ ->
                        False
                )
            , disabled True
            ]
            []
        , span [] [ text todo.title ]
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


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { remoteTodos = RemoteData.Loading }, getTodos )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotTasksResponse response ->
            ( { model | remoteTodos = response }, Cmd.none )


main : Platform.Program Flags Model Msg
main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        , view = view
        }
