<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Agent Memory gives AI Agents persistent memory across the turns of a conversation so they retain tool-call history and context instead of restarting from scratch each turn.

---

By default the AI Assistant API's `AgentRunner` throws away an agent's serialized state when the agent finishes a turn, so every new user message begins a completely fresh run with no memory of earlier tool calls, results, or reasoning. AI Agent Memory decorates the `AgentRunner` and, for an admin-selected allow-list of agents, keeps that state in a dedicated private temp-store bin that survives between turns. The next message resumes the agent with its previous context, enabling coherent multi-step workflows where each step builds on the last. A turn-aware history trimmer keeps the context window bounded (dropping middle turns while preserving the first turn and the most recent turns), and binary file data is stripped from messages before persistence. It depends on the `ai`, `ai_agents`, and `ai_assistant_api` projects and is a developer-facing extension of the Drupal AI agent stack.

---

- Give an AI agent memory across turns of a chat conversation.
- Retain tool-call history between user messages.
- Keep an agent's intermediate results and reasoning available on the next turn.
- Let multi-step agent workflows build on earlier steps.
- Avoid re-running tool calls the agent already made.
- Resume a finished agent with full context when the user replies.
- Continue an in-progress agent run while the frontend polls for progress.
- Opt individual agents into persistence with a checkbox settings form.
- Leave all non-selected agents on the default (stateless) AgentRunner.
- Bound the context window with turn-aware history trimming.
- Preserve the first turn (initial context) while dropping older middle turns.
- Always keep a configurable number of the most recent turns.
- Never split a tool call from its matching tool result when trimming.
- Cap the total persisted messages via `max_history_messages`.
- Discard stale state automatically when an agent finished and no new message arrived.
- Strip binary file attachments from messages before they are stored.
- Configure everything at `/admin/config/ai/agent-memory`.
- Build stateful, "assistant"-style agents on top of the AI module.
- Support taskable AI agents that carry out multi-turn tasks.
- Run on Drupal 10.3+ and Drupal 11.
- Integrate transparently via a service decorator (no code changes to callers).
