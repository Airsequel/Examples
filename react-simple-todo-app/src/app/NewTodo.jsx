import { useState } from "react"
import styled from "styled-components"
import { gql, useMutation } from "@apollo/client"

import { insertTodos, getTodos } from "./queries"

const NewTodoForm = styled.form`
  margin: 0;
`

const NewTodoInput = styled.input`
  width: 100%;
  font-size: 1.5rem;
  font-weight: 100;
  font-family: inherit;
  line-height: 1.4;
  outline: none;
  padding: 0.8rem 4rem;
  border: none;
  box-shadow: inset 0 -2px 1px rgba(0, 0, 0, 0.1);

  &::placeholder {
    font-style: italic;
    color: hsl(0, 0%, 70%);
  }
`


export default function NewTodo () {
  const [addTodo, { data, loading, error }] = useMutation(insertTodos, {
    refetchQueries: [getTodos],
  })
  const [todoTitle, setTodoTitle] = useState(null)

  if (loading) {
    return "Submitting..."
  }

  if (error) {
    return `Submission error! ${error.message}`
  }

  return (
    <NewTodoForm
      onSubmit={event => {
        event.preventDefault()

        if (!todoTitle || typeof todoTitle !== "string") {
          return
        }

        addTodo({ variables: {
          objects: [{ title: todoTitle.trim() }],
        }})
      }}
    >
      <NewTodoInput
        placeholder="What needs to be done?"
        onChange={event => setTodoTitle(event.target.value)}
        autoFocus
      />
    </NewTodoForm>
  )
}
