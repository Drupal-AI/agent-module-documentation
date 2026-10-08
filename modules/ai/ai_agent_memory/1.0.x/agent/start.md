<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Agent Memory (ai_agent_memory) — agent index

Persists AI-agent state across the turns of a conversation so agents retain tool-call history,
results, and reasoning instead of restarting fresh each turn. Package **AI**. Version **1.0.0**.
Core `^10.3 || ^11`. License GPL-2.0-or-later.

Depends on projects **`ai`**, **`ai_agents`**, and **`ai_assistant_api`** (module deps:
`ai_agents`, `ai_assistant_api`). No permissions file, no Drush, no plugins, no entities.

- **The service decorator, the persistence state machine, trimming, file-stripping, and how to
  operate it** → [services/memory-runner.md](services/memory-runner.md)
- **The settings form, config object + schema, route and permission** →
  [config/settings.md](config/settings.md)

## What it actually is

- A **service decorator**. `ai_agent_memory.services.yml` declares
  `ai_agent_memory.AgentMemoryRunner` with `decorates: ai_assistant_api.agent_runner`, wrapping the
  inner service via `@.inner`. Class `Drupal\ai_agent_memory\Service\AgentMemoryRunner` extends the
  upstream `AgentRunner`.
- The default `AgentRunner` deletes an agent's serialized state when it finishes a turn.
  `AgentMemoryRunner::runAsAgent()` intercepts the call: agents **not** in the
  `enabled_agents` config list delegate straight to `$this->inner`; enabled agents go through
  `runPersistent()`, which keeps state in a **private temp-store** bin `ai_agent_memory_threads`
  keyed by `$job_id`.
- Two helper services and one enum:
  - `ai_agent_memory.chat_history_trimmer` → `ChatHistoryTrimmer` (turn-aware context trimming).
  - `ai_agent_memory.chat_message_file_stripper` → `ChatMessageFileStripper` (removes binary file
    data before persistence).
  - `Drupal\ai_agent_memory\Enum\AgentState` — the `Fresh` / `Stale` / `CrossTurn` / `SameTurn`
    state machine (`AgentState::detect()`).

## Config & route

- Config object **`ai_agent_memory.settings`**: `enabled_agents` (sequence), `max_history_messages`
  (int, default 100), `keep_recent_turns` (int, default 5). Schema in
  `config/schema/ai_agent_memory.schema.yml`, install defaults in `config/install/`.
- One route **`ai_agent_memory.settings`** at `/admin/config/ai/agent-memory`
  (`SettingsForm`, permission **`administer site configuration`**), plus a menu link under
  *Configuration → AI*.
