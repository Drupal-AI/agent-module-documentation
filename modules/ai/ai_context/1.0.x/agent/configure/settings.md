<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Module settings

Config object **`ai_context.settings`** (schema `config/schema/ai_context.schema.yml`, marked
`FullyValidatable`). The UI splits it across sub-tabs under `/admin/config/ai/context/settings`:

| Route | Form | Covers |
|---|---|---|
| `ai_context.settings.general` | `Form\AiContextSettingsForm` | limits, token budget, provider, prompt prefix, subcontext, debug |
| `ai_context.settings.items` | `Form\AiContextItemSettingsForm` | new-item publish/revision defaults; links to Scheduler |
| `ai_context.settings.usage` | `Form\AiContextUsageSettingsForm` | usage-tracking toggle + retention |
| `ai_context.settings.agents` | `Form\AiContextAgentsForm` | per-agent config → [agents.md](agents.md) |
| `ai_context.settings.scope` | `Form\AiContextScopeOverviewForm` | scope enable/disable → [scopes.md](scopes.md) |
| `ai_context.settings.extensions` | `Controller\AiContextExtensionsController::view` | optional-module discovery |

`ai_context.overview` (`/admin/config/ai/context/overview`) is the landing page; the bare
`/admin/config/ai/context` (`ai_context.context_redirect`) redirects to the overview or the item
list per `show_overview_page`. All settings routes require `administer ai context`.

## Keys (`ai_context.settings`) with defaults

| Key | Default | Meaning / constraint |
|---|---|---|
| `max_global_items` | `3` | Max global-scope items auto-included (Range 0–10). |
| `max_tokens` | `1200` | Token budget for the rendered context block (Range min 100). |
| `provider_config` | `{use_default: true, provider:'', model:'', config:{}}` | `ai.provider_config`; which AI provider/model to use for tokenizer + conditional subcontext. `use_default:true` defers to `ai.settings`. |
| `show_overview_page` | `true` | Gates the overview page and its access check `_ai_context_overview_access`. |
| `context_prefix` | *(instructional sentence)* | Text prepended to injected context (NotBlank, ≤255). See [events.md](../events/events.md). |
| `usage_tracking_enabled` | `false` | Turns on `ai_context_usage` logging + the Usage tab (`_ai_context_usage_access`). |
| `usage_max_records` | `10000` | Retention cap (pruned on cron). |
| `usage_max_age` | `7776000` | Retention age in seconds (90 days). |
| `debug_logging` | `false` | Verbose selection/render logging to channel `ai_context`. |
| `subcontext_enabled` | `true` | Enable parent/child subcontext hierarchy. |
| `conditional_subcontext_enabled` | `true` | Let the LLM decide when a conditional child applies. |
| `conditional_max_parents` | `3` | Max parents sent to the LLM per resolve call (Range 1–20). |
| `default_status` | `true` | Publish new context items by default. |
| `new_revision` | `true` | Create a new revision by default. |

## Set via drush / PHP

```bash
ddev drush config:set ai_context.settings max_tokens 2000 -y
ddev drush config:set ai_context.settings usage_tracking_enabled true -y
```

```php
\Drupal::configFactory()->getEditable('ai_context.settings')
  ->set('max_global_items', 5)
  ->set('context_prefix', 'Company style rules follow. Apply when relevant.')
  ->save();
```

Changing `usage_tracking_enabled`/token settings is observed by
`EventSubscriber\AiContextSettingsConfigSubscriber`, which can schedule a token-count backfill
(`Plugin\QueueWorker\AiContextTokenCountBackfill`). Item-publish/revision defaults live in the
same object (`default_status`, `new_revision`) and are read by the item form.
