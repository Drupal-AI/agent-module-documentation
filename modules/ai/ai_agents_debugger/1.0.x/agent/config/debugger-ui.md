<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The debugger UI: opening it, form fields, and the React views

## Opening the debugger
- `ai_agents_debugger_entity_operation()` (`ai_agents_debugger.module`) adds a **Debug** operation (weight
  31) to every `Drupal\ai_agents\Entity\AiAgent` row on the agent list, linking to
  `ai_agents_debugger.form` with `agent_id`.
- Direct URL: `/admin/config/ai/agents/debug` (permission `debug ai agents`). A `?agent_id=…` query
  pre-selects the agent (default fallback `my_assistant`).

## The form — `AIAgentsDebuggerForm` (id `ai_agents_debugger`)
`buildForm()` attaches library `ai_agents_debugger/debugger` and sets
`drupalSettings.aiAgentsDebugger` = `{startUrl, pollUrl, systemPromptLoadUrl, systemPromptSaveUrl,
askAiUrl}` (the poll/load URLs contain `__UUID__` / `__AGENT_ID__` placeholders the JS substitutes).
Layout is two panels (`.debugger-panel--config` and `.debugger-panel--monitor`) with a drag resize handle.

Config-panel fields (left):
- **Chat History** — `#type => 'chat_history'` (element provided by AI Agents), default one empty `user`
  message. Composes the `chat_history` sent to `runAgent`.
- **Agent** — `select`, required, options = every AI Agent plugin definition label (from
  `agentsManager->getDefinitions()`, `asort`ed). Default from `?agent_id`, else `my_assistant`.
- **Advanced** (collapsed `details`):
  - **Model** — `select`, required; options from
    `providerManager->getSimpleProviderModelOptions('chat', TRUE, TRUE, [ChatJsonOutput])`; default is the
    configured `chat_with_tools` provider/model as `provider__model`.
  - **Edit System Prompt** — a JS button (`#debugger-edit-system-prompt`) that opens the system-prompt
    editor modal, which loads/saves via the `system_prompt.load` / `system_prompt.save` endpoints.
  - **Spoof Tokens** — `textarea`, one `[token:name]=value` per line; the JS packs these into the
    `spoof_tokens` JSON sent to `runAgent`, where they are merged into the agent's token contexts (for
    `ConfigAiAgentInterface` agents). Used to supply token values that would not otherwise be available in
    a debug run.
  - **Files** — `managed_file`, multiple; uploaded file ids are POSTed as `files[]` and attached to the
    last user message (images need a vision model).
  - **Run Agent** — submit button (`#debugger-run-agent`); the real submission is the JS POST to
    `startUrl` (`submitForm()` in PHP is intentionally empty).

Monitor panel (right): an empty `#debugger-monitor` (list) and `#debugger-graph` container where the React
app mounts. The React app draws its own header/toolbar.

## The React monitor (`js/dist/debugger-app.iife.js`, sources `js/src/**`)
- Mounts on the monitor container; polls `pollUrl` for progress items while a run executes and renders them.
- **List View** (`SequenceView`/`MonitorList`/`MonitorItem`) — every step in order: thoughts, tool calls,
  tool output; click an item for verbose JSON (`Modal`).
- **Graph View** (`GraphView` + `utils/mermaidGenerator.ts`) — a mermaid flowchart of loops, AI requests,
  tools and subagents.
- **Sequence Diagram** (`SequenceView`) — mermaid sequence of main-agent ↔ subagent messages when agents
  call other agents.
- **Ask AI** (`AskAiChat`) — posts `{question, agent_data, chat_history, model}` to `askAiUrl` and shows
  the answer.
- **System Prompt Editor** (`SystemPromptEditor`) — loads/saves an agent's `system_prompt`.
- Markdown is rendered through `MarkdownRenderer` (react-markdown + `remark-gfm`, content pre-sanitized with
  DOMPurify; links limited to http/https/mailto). Mermaid diagrams come from `mermaid@10` loaded from the
  jsDelivr CDN (declared in `ai_agents_debugger.libraries.yml`); diagram labels are passed through
  `escapeMermaidLabel()`.
- Import/export: a run's captured data can be exported to a file and re-imported to replay it in another
  environment.

## Libraries
`ai_agents_debugger.libraries.yml` defines `debugger` (production: `debugger-app.iife.js` + init/layout JS +
`css/debugger.css` + external `mermaid@10`) and `debugger_dev` (for `npm run dev`, without the compiled
bundle). Both depend on `core/drupal` and `core/drupalSettings`.

## Notes on operation
- No configuration form and no config entities/schema ship with this module — behaviour is driven entirely
  by the run parameters you submit.
- Chat-history support in AI depends on the upstream change referenced in the project page; without it the
  chat-history field may not round-trip fully.
