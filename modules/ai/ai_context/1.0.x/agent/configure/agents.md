<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Per-agent context configuration

Config object **`ai_context.agents`** holds a `agents:` sequence, one entry per `ai_agents` agent
that should receive (or be excluded from) context. Edited at
`ai_context.settings.agents` (`Form\AiContextAgentsForm`) and per-agent at
`ai_context.settings.agent_edit` (`/admin/config/ai/context/settings/agents/{ai_agent}/edit`,
`Form\AiContextAgentForm`). Reads/writes are centralised in
`Service\AiContextRequestFactory::findAgentConfig()` — other code should call that, not read the
config directly.

## Per-agent keys (schema `ai_context.agents`)

| Key | Type | Effect |
|---|---|---|
| `id` | string | The `ai_agents` agent machine name. |
| `scope_subscriptions` | map: `scope_id → [value_id, …]` | Which scope values this agent opts into (e.g. `use_case: [working_with_text]`, `language: [en]`, `tag: ['5','7']`). |
| `always_include` | `[item_id, …]` | Item IDs always injected, ignoring scope matching. |
| `never_include` | `[item_id, …]` | Item IDs never injected, overriding everything. |
| `max_global_items` | int (0–10) | Per-agent override of the global-items cap. |
| `max_tokens` | int (≥100) | Per-agent override of the token budget. |
| `selection_mode` | `minimal` \| `match_all` | `minimal` (default) = global + context-auto + overrides only; `match_all` = consider the whole catalogue. |
| `loop_aware` | bool | When true, skip re-injecting context on agent loop iterations > 0 (token optimisation). |
| `allow_context_injection` | bool (default `true` when unset) | Master switch for **push** injection into the system prompt. |

Missing per-agent values fall back to `ai_context.settings`. Limits are bounds-checked in
`AiContextRequestFactory::resolveLimit()` (agent → global → built-in default, invalid values logged).

## Push vs. pull

- **Push** — `EventSubscriber\AiContextSystemPromptSubscriber` builds a request via
  `requestFactory->fromAgent()` and appends the result to the agent's system prompt. Governed by
  `allow_context_injection` (`isInjectionAllowed()`); `loop_aware` (`isLoopAware()`) suppresses
  re-injection on later loops. See [../events/events.md](../events/events.md).
- **Pull** — the `context_tools` function-call plugins honour `scope_subscriptions`/overrides
  regardless of `allow_context_injection`. See [../api/function-calls.md](../api/function-calls.md).

## Example (drush)

```bash
ddev drush config:set ai_context.agents agents.0.id my_agent -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('ai_context.agents')->set('agents', [
  [
    'id' => 'my_agent',
    'scope_subscriptions' => ['use_case' => ['working_with_text'], 'language' => ['en']],
    'always_include' => ['12'],
    'never_include' => ['99'],
    'max_tokens' => 2000,
    'selection_mode' => 'minimal',
    'loop_aware' => TRUE,
    'allow_context_injection' => TRUE,
  ],
])->save();
```

`Service\AiContextAgentsConfigValidator` validates this structure on config import
(`EventSubscriber\AiContextConfigImportValidateSubscriber`). Live token-budget summaries per
subscription are computed by `Service\AiContextSubscriptionBudgetCalculator`.
