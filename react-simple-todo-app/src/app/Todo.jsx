import styled from "styled-components"
import { gql, useMutation } from "@apollo/client"

import {
  getTodos,
  updateTodos,
  deleteTodos,
} from "./queries"


const TodoItem = styled.li`
  font-size: 1.5rem;
  border-bottom: 1px solid hsl(0, 0%, 85%);
  position: relative;
`

const Toggle = styled.input`
  appearance: none;
  background: none;
  border: none;
  bottom: 0;
  cursor: pointer;
  height: 40px;
  margin: auto 0;
  outline: none;
  position: absolute;
  text-align: center;
  top: 0;
  width: 40px;
`

const Icon = styled.svg`
  cursor: pointer;
  margin: auto 0;
  position: absolute;
  top: 0;
  bottom: 0;
`

const TodoLabel = styled.label`
  display: inline-block;
  white-space: pre-line;
  word-break: break-all;
  padding: 15px 60px 15px 15px;
  margin-left: 45px;
  line-height: 1.2;
`

const CompletedLabel = styled(TodoLabel)`
  color: hsl(0, 0%, 85%);
  text-decoration: line-through;
`

const RemoveButton = styled.button`
  cursor: pointer;
  outline: none;
  display: none;
  position: absolute;
  top: 0;
  right: 10px;
  bottom: 0;
  width: 40px;
  height: 40px;
  margin: auto 0;
  font-size: 30px;
  color: hsl(0, 32%, 70%);
  margin-bottom: 11px;
  transition: color 0.2s ease-out;
  padding: 0;
  border: 0;
  background: none;
  vertical-align: baseline;
  appearance: none;
  font-smoothing: antialiased;

  ${TodoItem} &:after {
    content: '×';
  }

  ${TodoItem}:hover & {
    display: block;
  }
`


export default function Todo ({
  rowid,
  title,
  completed,
}) {
  const [editTodos] = useMutation(updateTodos, {
    refetchQueries: [getTodos],
  })
  const [rmTodos] = useMutation(deleteTodos, {
    refetchQueries: [getTodos],
  })

  return (
    <TodoItem>
      <Toggle
        type="checkbox"
        defaultChecked={completed}
      />
      <Icon
        width="40"
        height="40"
        viewBox="-10 -18 100 135"
        onClick={() => {
          editTodos({ variables: {
            filter: { rowid: { eq: rowid } },
            set: {
              title: title,
              completed: !completed,
            },
          }})
        }}
      >
        {completed
          ? <>
            <circle
              cx="50" cy="50" r="50" fill="none"
              stroke="#bddad5" strokeWidth="3"
            />
            <path fill="#5dc2af" d="M72 25L42 71 27 56l-4 4 20 20 34-52z"/>
          </>
          : <circle
            cx="50" cy="50" r="50" fill="none"
            stroke="#ededed" strokeWidth="3"
          />
        }
      </Icon>
      {completed
        ? <CompletedLabel>{title}</CompletedLabel>
        : <TodoLabel>{title}</TodoLabel>
      }
      <RemoveButton onClick={() => {
        rmTodos({ variables: {
          filter: { rowid: { eq: rowid } },
        }})
      }}/>
    </TodoItem>
  )
}
