import styled from "styled-components"
import { gql } from "@apollo/client"


const Filter = styled.ul`
  display: flex;
  max-width: 200px;
  padding: 0;
  margin: 0;
  background-color: white;
  list-style-type: none;
  justify-content: space-between;
  margin: 0 auto;
`

const Item = styled.li`
  padding: 4px;
  cursor: pointer;
  border-width: 1px;
  border-style: solid;
  border-radius: 3px;
  border-color: ${props => props.active
    ? "rgba(175, 47, 47, 0.2);"
    : "transparent;"
}
`


export default function ({ activeFilter, setFilter }) {
  function filterTodo (event) {
    console.debug(event)
    setFilter(event.target.textContent)
  }

  return (
    <Filter>
      <Item active={activeFilter === "All"} onClick={filterTodo}>
        All
      </Item>
      <Item active={activeFilter === "Active"} onClick={filterTodo}>
        Active
      </Item>
      <Item active={activeFilter === "Completed"} onClick={filterTodo}>
        Completed
      </Item>
    </Filter>
  )
}
