<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Lifecycle (ai_content_lifecycle) — agent index

Asks the site's **drupal/ai chat provider** whether an entity's content is **outdated**, and records the verdict
on a revisionable **`content_life_cycle`** tracking entity for editor review. Package `AI`. **Depends on the `ai`
module** (`ai:ai`). Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.0. Provides one permission, a config
schema, and a content entity type. **No HTTP client or API keys of its own — all LLM access is via `@ai.provider`.**

- **Settings form, config object + schema, permissions, and routes** → [config/settings.md](config/settings.md)
- **The analyzer, batch process, and the `content_life_cycle` entity** → [api/analyzer.md](api/analyzer.md)

## What it provides (from source)

- **Entity type** `content_life_cycle` (`src/Entity/ContentLifeCycle.php`) — revisionable, translatable,
  `admin_permission = "administer content_life_cycle"`; base fields include `label`, `entity_type`,
  `entity_bundle`, `entity_id`, `uid`, `ai_prompt_results` (text_long), `review_status` (list: pending/analyzed/
  reviewed/updated/ignored). Full admin route set via `AdminHtmlRouteProvider` (collection at
  `/admin/content/content-life-cycle`).
- **Service** `ai_content_lifecycle.content_ai_analyzer` → `ContentAIAnalyzer` — renders an entity, converts it to
  Markdown (`League\HTMLToMarkdown`), builds the prompt, calls `@ai.provider` chat, parses the JSON verdict.
- **Batch** `Controller\ContentLifecycleBatchController::batchCreate()` + `BatchProcess::processBundle()` — analyze
  all enabled bundles and create/update lifecycle entities for flagged items.
- **Settings form** `Form\ContentLifecycleSettingsForm` (config `ai_content_lifecycle.settings`, schema in
  `config/schema/`). Entity edit form `Form\ContentLifeCycleForm`; list builder `ContentLifeCycleListBuilder`.
- **Config** ships two `system.action` entities (`content_life_cycle_delete_action`,
  `content_life_cycle_save_action`) operating on `content_life_cycle` entities, and an **optional** View
  `views.view.content_life_cycle` with node relationships (`hook_views_data_alter`).
- **Hooks** (`.module`): `hook_theme` + `template_preprocess_content_life_cycle`, `hook_user_cancel`
  (reassign lifecycle records to anonymous), `hook_user_predelete` (delete the user's lifecycle records +
  revisions), `hook_views_data_alter`.

## Routes & permissions

| Route | Path | Permission |
|---|---|---|
| `ai_content_lifecycle.settings` | `/admin/config/ai/ai-content-lifecycle` | `administer ai content lifecycle settings` |
| `ai_content_lifecycle.batch_create` | `/admin/config/ai/ai-content-lifecycle/batch-create` | `administer ai content lifecycle settings` |
| `content_life_cycle` entity routes | `/admin/content/content-life-cycle*` | `administer content_life_cycle` (`restrict access: true`) |

> **Config caveat:** both module routes require `administer ai content lifecycle settings`, but
> `ai_content_lifecycle.permissions.yml` defines only `administer content_life_cycle`. The settings/batch
> permission is **undefined**, so those two routes fail closed — no role can hold the permission and only user 1
> (which bypasses access checks) can reach them. See [config/settings.md](config/settings.md).
