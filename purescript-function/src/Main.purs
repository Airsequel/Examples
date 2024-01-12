module Main where

import Prelude (discard, pure, ($), (<>))

import Data.Argonaut.Core (Json, jsonSingletonObject, fromString, stringify)
import Effect (Effect)
import Effect.Class.Console (log)

type Context = {
  functionId :: String,
  method :: String, -- "GET", "POST", "PATCH", "PUT", "DELETE"
  headers :: Json,
  data :: Json
}

main :: Context -> Effect Json
main context = do
  log $ "Function ID: " <> context.functionId
  log $ "Method: " <> context.method
  log $ "Headers: " <> stringify context.headers
  log $ "Data: " <> stringify context.data

  pure $
    jsonSingletonObject
    "data"
    (jsonSingletonObject
      "message" (fromString "Hello, world!")
    )
