import ReactDOM from "react-dom"
import {
  ApolloClient,
  ApolloProvider,
  InMemoryCache,
} from "@apollo/client"
import { createGlobalStyle } from "styled-components"

import App from "./app/App.jsx"
import { resolvers, defaults } from "./resolvers"


const GlobalStyle = createGlobalStyle`
  body {
    font-size: 14px;
    font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
    line-height: 1.4;
    color: hsl(0, 0%, 30%);
    background-color: hsl(200, 50%, 95%);
    min-width: 230px;
    max-width: 550px;
    margin: 0 auto;
    font-weight: 300;
  }
`
const typeDefs = ""
const client = new ApolloClient({
  uri: "http://localhost:4185/dbs/todos/graphql",
  cache: new InMemoryCache(),
})


ReactDOM.render(
  <ApolloProvider client={client}>
    <GlobalStyle />
    <App />
  </ApolloProvider>,
  document.getElementById("root"),
)
