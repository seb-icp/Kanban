import { Actor, HttpAgent } from "@dfinity/agent"
import { idlFactory as kanban_idl, canisterId as kanban_id } from "dfx-generated/kanban"

const agentOptions = {
  host: "http://localhost:8000",
}

const agent = new HttpAgent(agentOptions)
const kanban = Actor.createActor(kanban_idl, { agent, canisterId: kanban_id })

export { kanban }