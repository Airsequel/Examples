import { gql } from "@apollo/client"


export const insertTodos = gql`
  mutation InsertTodos (
    $objects: [todos_insert_input]
  ) {
    insert_todos(objects: $objects) {
      affected_rows
    }
  }
`

export const getTodos = gql`
  query GetTodos {
    todos {
      rowid
      title
      completed
    }
  }
`

export const updateTodos = gql`
  mutation UpdateTodos (
    $filter: todos_filter,
    $set: todos_set_input
  ) {
    update_todos(
      filter: $filter,
      set: $set,
    ) {
      affected_rows
    }
  }
`

export const deleteTodos = gql`
  mutation DeleteTodos (
    $filter: todos_filter
  ) {
    delete_todos(filter: $filter) {
      affected_rows
    }
  }
`
