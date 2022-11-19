import { useState } from "react"
import { useQuery } from "@apollo/client"
import styled from "styled-components"

import NewTodo from "./NewTodo.jsx"
import Todo from "./Todo.jsx"
import Filter from "./Filter.jsx"
import { getTodos } from "./queries.js"


const Title = styled.h1`
  font-size: 6em;
  line-height: 1.2;
  font-weight: 100;
  text-align: center;
  color: hsla(240, 60%, 40%, 0.5);
`

const MainSection = styled.section`
  border-top: 1px solid hsl(0, 0%, 90%);
  box-shadow: 0 2px 4px 0 rgb(0 0 0 / 20%), 0 25px 50px 0 rgb(0 0 0 / 10%);
`

const Todos = styled.ul`
  padding: 0;
  margin: 0;
  background-color: white;
  list-style-type: none;
`

const Footer = styled.div`
  background-color: white;
  padding: 12px 0;
`


function getTodoElements (filter, todos) {
  const todoElements = todos
    .filter(todo =>
      filter === "All" ||
      (filter === "Completed" && todo.completed) ||
      (filter === "Active" && !todo.completed),
    )
    .reverse()  // Show latest todo first
    .map(todo =>
      <Todo key={todo.rowid} {...todo} />,
    )

  return todoElements
}


export default function App ({ todos }) {
  const { loading, error, data } = useQuery(getTodos)
  // Filter values: All, Active, Completed
  const [todoFilter, setTodoFilter] = useState("All")

  if (loading) {
    return <p>Loading...</p>
  }

  if (error) {
    console.error(error)
    return <p>Error :(</p>
  }

  console.debug(todoFilter)

  return (
    <>
      <header>
        <Title>Todo App</Title>
      </header>
      <MainSection>
        <header>
          <NewTodo />
        </header>
        <Todos>
          {getTodoElements(todoFilter, data.todos)}
        </Todos>
        <Footer>
          <Filter activeFilter={todoFilter} setFilter={setTodoFilter} />
        </Footer>
      </MainSection>
    </>
  )
}
