<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Agents Debugger is a debugging tool for monitoring AI Agents actions, thoughts, tool calls and responses in real-time.

---

AI Agents Debugger extends the **AI Agents** framework with an interactive debugging UI. From the agent
list you click **Debug** on any AI Agent and get a two-panel workbench: a configuration panel where you
compose a chat history, pick the agent, choose any provider/model, upload files, spoof token values and
edit the agent's system prompt; and a monitoring panel — a bundled React app — that streams what the agent
does. It renders the run three ways: a sequential **List View** (every thought, tool call and tool output),
a **Graph View** (a mermaid flowchart of how actions relate), and a **Sequence Diagram** (agent-to-subagent
conversation when agents call other agents). Runs can be exported and re-imported, so a run captured on one
environment can be replayed on another, and with the optional AI Agent Handler Agent installed you can chat
about the captured run. It depends on the AI Agents module (and, transitively, the base AI module and a
configured provider); it is packaged under AI Tools and ships its own `debug ai agents` permission.

---

- Debug an AI Agent from the agent list via the per-row **Debug** operation link.
- Compose a multi-message chat history to feed an agent for a test run.
- Run any registered AI Agent plugin against a chosen provider and model.
- Pick any provider/model that supports chat-with-JSON-output for the run.
- Watch agent thoughts, tool calls and tool output stream in the List View.
- Visualize the agent flow as a mermaid Graph View flowchart.
- Visualize agent-to-subagent conversation as a mermaid Sequence Diagram.
- Click any action to inspect its verbose JSON data.
- Upload files (including images for vision models) to hand to the agent.
- Spoof token context values (e.g. `[current-user:id]=1`) to test agents that expect tokens.
- Override token entities and scalar tokens for a run without changing real data.
- Edit an agent's system prompt inline and re-run to compare behaviour.
- Load and save an agent's `system_prompt` through the debugger.
- Export a captured run and re-import it to replay it elsewhere (prod-to-dev).
- Ask an AI assistant questions about the captured run (Ask AI panel).
- Poll long-running agent runs for incremental progress updates.
- Understand which loop, request and tool produced a given result.
- Diagnose prompt, tool and routing problems while building agents.
- Replace the older Agent Explorer with a richer, tool-aware trace.
- Restrict debugging to trusted developers via the `debug ai agents` permission.
- Develop and troubleshoot ReAct-style agents built on the AI Agents module.
