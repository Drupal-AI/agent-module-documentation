<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Lifecycle — settings, permissions, config

## Install & enable

```bash
composer require drupal/ai_content_lifecycle
drush en ai_content_lifecycle -y
```

Requires the **`ai`** module (`ai:ai` in `*.info.yml`), which supplies the `@ai.provider` chat provider used for
analysis. Configure at least one AI provider/model in the `ai` module first.

## Permissions (`ai_content_lifecycle.permissions.yml`)

Only one permission is defined:

| Permission | Restricted | Grants |
|---|---|---|
| `administer content_life_cycle` | **yes** (`restrict access: true`) | The `content_life_cycle` entity's `admin_permission` — collection, add/edit/delete, revisions, the two `system.action`s. |

**Undefined-permission caveat:** `ai_content_lifecycle.routing.yml` gates both the settings form and the batch
trigger with `_permission: 'administer ai content lifecycle settings'`, but that string is **not defined** in the
permissions file. In Drupal a route requiring a non-existent permission is grantable to no role, so
`/admin/config/ai/ai-content-lifecycle` and `/admin/config/ai/ai-content-lifecycle/batch-create` are reachable
**only by user 1** (which bypasses access). This is a functional bug (fails closed / safe), not a bypass —
configuring the module currently requires the superuser unless the permission string is corrected to
`administer content_life_cycle`.

## Settings form (`Form\ContentLifecycleSettingsForm`)

Route `ai_content_lifecycle.settings`, path **`/admin/config/ai/ai-content-lifecycle`**. `ConfigFormBase` editing
config object **`ai_content_lifecycle.settings`** (schema in `config/schema/ai_content_lifecycle.schema.yml`).

Form structure:

- **Advanced LLM settings** (`ai_settings`, tree):
  - `default_model` — select from `AiProviderPluginManager::getSimpleProviderModelOptions('chat')`; empty = use the
    AI module's default chat provider. Stored as `provider_id__model_id`.
  - `pre_prompt` — textarea prepended to the built-in technical system prompt (default = `DEFAULT_SYSTEM_PROMPT`).
- **Mark my content when** (`default_prompt`) — the fallback condition text substituted into the system prompt.
- **What to check** (`entity_types`, tree) — for every content entity type: an `enabled` checkbox, a `view_mode`
  select (for content extraction; default `search_index`), a `bundles` checkboxes set, and per-bundle prompt
  textareas. Entity types without bundles get a single `text_format` prompt.
- **Analyze content** — a link button to route `ai_content_lifecycle.batch_create`.

`submitForm()` writes `default_prompt`, `default_model`, `pre_prompt`, `enabled_entity_types`, `enabled_bundles`,
`bundle_prompts`, and `view_modes` back to config. (Note: `analyzeContent()` reads `pre_prompt` from
`ai_content_lifecycle.settings`, while `extractEntityContent()` reads `view_modes` from a config name containing
stray spaces — `'ai_content_lifecycle . settings'` — so the configured view mode is effectively not found and the
extractor falls back to `search_index`. A source-level bug worth noting when documenting behaviour.)

## Config object shape (schema)

`ai_content_lifecycle.settings` (`config_object`):

- `enabled_entity_types`: sequence of booleans keyed by entity type id.
- `enabled_bundles`: sequence (entity type) → sequence (bundle) → string.
- `bundle_prompts`: sequence → sequence → mapping `{ value: text, format: string }`.
- `view_modes`: sequence → sequence → mapping `{ value: text, format: string }`.
- `default_prompt`: text.

(`pre_prompt` and `default_model` are written by the form but are not declared in the shipped schema.)

## Shipped config

- `config/install/system.action.content_life_cycle_delete_action.yml` — "Delete content life cycles"
  (`entity:delete_action:content_life_cycle`).
- `config/install/system.action.content_life_cycle_save_action.yml` — "Save content life cycles"
  (`entity:save_action:content_life_cycle`).
  Both act on **`content_life_cycle` tracking entities**, not on the referenced content, and are exposed through
  Views bulk operations gated by the entity's `administer content_life_cycle` access.
- `config/optional/views.view.content_life_cycle.yml` — a Views listing (installed only when Views is present) with
  node relationships added by `hook_views_data_alter`.
