<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content entities

The module defines two content entity types (no config entities). Both use core field-storage
schema, not config schema.

## `ai_context_item` — the context content

`Entity\AiContextItem`, extends `EditorialContentEntityBase`. Translatable, revisioned
(`show_revision_ui`), owner-aware. Base table `ai_context_item`; `admin_permission:
administer ai context`. Storage `AiContextItemStorage`, list builder `AiContextItemListBuilder`,
translation handler `AiContextItemTranslationHandler`, access handler
`AiContextItemAccessControlHandler` (see [../permissions/permissions.md](../permissions/permissions.md)).
Managed at `/admin/config/ai/context/items`.

| Field | Type | Role |
|---|---|---|
| `label` | string | Item name. |
| `description` | string_long | Editorial description (not sent to the LLM). |
| `purpose` | string_long | Short "why/when" shown to the LLM as `purpose:` and used for conditional-subcontext relevance. |
| `content` | string_long | The actual guidance text injected (Markdown; rendered as `guidance:`). |
| `token_count` | integer | Cached token estimate (backfilled via queue/cron). |
| `parent` | entity_reference → `ai_context_item` | One-level subcontext parent. |
| `subcontext_type` | list_string | `required` (always with parent) or `conditional` (LLM decides). |
| `inherit_parent_scope` | boolean | Child inherits parent's scope values. |
| `priority` | list_integer | Selection priority (see `AiContextItemPriority`). |
| `scope` | map | Stored scope values keyed by scope plugin id (drives matching). |
| `created`, `changed` | timestamps | — |

Plus editorial base fields: `status` (published), `uid`/`owner`, `langcode`, and revision metadata.
Only **published** items are ever rendered into a prompt. Content is authored by trusted roles and
sanitized on display by `Markdown\MarkdownRenderer` (`html_input: strip`, `allow_unsafe_links:
FALSE`, plus `Xss::filter()`).

## `ai_context_usage` — usage log

`Entity\AiContextUsage`, plain `ContentEntityBase`. Written by `Service\AiContextUsageTracker` when
`usage_tracking_enabled` is on; pruned by cron per `usage_max_records`/`usage_max_age`. Surfaced by
the `view.ai_context_usage` View and `Controller\AiContextUsageRecordController`.

| Field | Type | Role |
|---|---|---|
| `context_item_id` | entity_reference → `ai_context_item` | Which item was used. |
| `agent_id` | string | Agent machine name that used it. |
| `runner_id` | string | Agent run identifier (groups a single execution). |
| `entity_item_type` / `entity_item_id` | string / integer | Entity the run created or modified. |
| `tools_used` | string_long | JSON list of tool plugin ids invoked during the run. |
| `routes` | string_long | JSON list of routes/paths the context was used on. |
| `created`, `changed` | timestamps | — |

Custom Views field plugins (`Plugin\views\field\*`) render item/agent/entity/usage links and
JSON-array columns for the usage report.
