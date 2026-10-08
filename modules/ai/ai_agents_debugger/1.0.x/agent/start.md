<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Agents Debugger (ai_agents_debugger) — agent index

Interactive debugging workbench for the **AI Agents** framework. Adds a **Debug** operation to every
`ai_agent` config entity that opens a two-panel UI (config form + a bundled React monitor) to run an agent
and watch its thoughts, tool calls and responses in a List / Graph / Sequence view. Package `AI Tools`.
Depends on `ai_agents` (composer: `drupal/ai:^1.2`, `drupal/ai_agents:^1.2`). Suggests `ai_agent_agent`
(the "Ask AI about the run" chat). Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.0-beta2.

- **Routes, controller methods, permissions, request/response shapes, and the ProgressService** →
  [api/endpoints.md](api/endpoints.md)
- **The debugger UI: how to open it, every form field, spoof tokens, files, the React views, the
  attached library** → [config/debugger-ui.md](config/debugger-ui.md)

## What it actually is

- **No config entities, no config schema, no plugin types, no Drush.** It ships one form, one controller,
  one service, one permission, one hook, and a compiled React/mermaid front-end.
- **Permission:** `debug ai agents` (`ai_agents_debugger.permissions.yml`, `restrict access: true`). Two
  routes reuse the AI Agents core permission `administer ai_agent` (system-prompt load/save).
- **Hook:** `ai_agents_debugger_entity_operation()` (`.module`) adds a `debug` operation link to every
  `Drupal\ai_agents\Entity\AiAgent` entity, pointing at `ai_agents_debugger.form`.
- **Form:** `Drupal\ai_agents_debugger\Form\AIAgentsDebuggerForm` (id `ai_agents_debugger`) — builds the
  config panel and mounts the React app; attaches library `ai_agents_debugger/debugger` and
  `drupalSettings.aiAgentsDebugger` with the endpoint URLs. Submission is handled client-side; the PHP
  `submitForm()` is empty.
- **Controller:** `Drupal\ai_agents_debugger\Controller\AIAgentsDebuggerController` — five JSON endpoints:
  `runAgent`, `pollAgent`, `loadSystemPrompt`, `saveSystemPrompt`, `askAi`.
- **Service:** `ai_agents_debugger.progress_service` = `Drupal\ai_agents_debugger\Service\ProgressService`,
  wrapping `ai_agents.agent_status_poller` + `ai_agents.private_temp_status_storage`.
- **Front-end:** `js/dist/debugger-app.iife.js` (Vite/React build; sources in `js/src/**`), `mermaid@10`
  from jsDelivr CDN, `css/debugger.css`. Renders List/Graph/Sequence views + modals.

## Routes (all under `/admin/config/ai/agents/debug`)

| Route | Path | Method | Permission |
|---|---|---|---|
| `ai_agents_debugger.form` | `…/debug` | GET | `debug ai agents` |
| `ai_agents_debugger.start` | `…/debug/start` | POST | `debug ai agents` |
| `ai_agents_debugger.poll` | `…/debug/poll/{uuid}` | GET | `debug ai agents` |
| `ai_agents_debugger.system_prompt.load` | `…/debug/system-prompt/{agent_id}` | GET | `administer ai_agent` |
| `ai_agents_debugger.system_prompt.save` | `…/debug/system-prompt/save` | POST | `administer ai_agent` |
| `ai_agents_debugger.ask_ai` | `…/debug/ask-ai` | POST | `debug ai agents` |

## Install

`composer require drupal/ai_agents_debugger` then `drush en ai_agents_debugger -y`. Grant `debug ai agents`
to the roles that should use the debugger, then open an agent's **Debug** link or visit
`/admin/config/ai/agents/debug`.
