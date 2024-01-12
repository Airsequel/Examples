module Test.Main where

import Prelude

import Data.Argonaut.Core (Json, jsonSingletonObject, fromString, stringify)
import Effect (Effect)
import Effect.Class.Console (log)
import Main as Main

exampleObject :: Json
exampleObject =
    jsonSingletonObject
      "name"
      (fromString "John")

main :: Effect Unit
main = do
  response <- Main.main {
    functionId: "func123",
    method: "GET",
    headers: exampleObject,
    data: exampleObject
  }
  log $ stringify response
  pure unit
