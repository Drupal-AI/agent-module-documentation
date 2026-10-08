<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Cleanup (ai_content_cleanup) — agent index

An **admin dashboard** that scans node text fields for markup problems and **rewrites them in place** with
rule-based cleanup. Detects broken HTML, inline styles, heading jumps, missing `alt`, empty elements and
deprecated tags; the side-by-side editor applies the cleaned markup back to a node as a new revision. Package
`Content`. Depends on core **`node`** and **`text`**. Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 1.0.1.

> **Naming note:** despite "AI" in the name, this release does the cleanup with **regex + DOMDocument**
> transformations (`Service\ContentCleanupProcessor` / `ContentCleanupAnalyzer`). There is **no LLM call and no
> drupal/ai dependency** in the code. "AI score" / "confidence" values shown in the UI are computed heuristics.

- **Settings form, config keys, permissions, and routes** → [config/settings.md](config/settings.md)
- **The scan/analyze/clean pipeline, DB tables, and the apply flow** → [api/pipeline.md](api/pipeline.md)

## What it provides (from source)

- **Controller** `Controller\AiContentCleanupController` — pages: `dashboard`, `scan`, `results`, `editor`
  (+ `editor_node`), `applyChanges`, `saveTemplate` (+ node variant), `issue`, `bulk`, `reports`, `templates`,
  `history`. All render the `ai_content_cleanup_page` theme (one Twig template with per-section branches).
- **Services** (`ai_content_cleanup.services.yml`):
  - `ai_content_cleanup.analyzer` → `Service\ContentCleanupAnalyzer` — scans nodes, detects issues, reads/writes
    the issue table, builds dashboard/report/history data.
  - `ai_content_cleanup.processor` → `Service\ContentCleanupProcessor` — `cleanHtml()` (rule pipeline) and
    `cleanNode()` (mutates + saves a node), plus history recording.
- **Forms** `Form\SettingsForm` (config object `ai_content_cleanup.settings`) and `Form\TemplateForm` (edits
  rule-preset "templates" stored in State).
- **Permissions** (`ai_content_cleanup.permissions.yml`): `access ai content cleanup` (view) and
  `administer ai content cleanup` (`restrict access: true`; editor, bulk, templates, apply).
- **DB tables** (`ai_content_cleanup.install`): `ai_content_cleanup_issue`, `ai_content_cleanup_history`.
- **Theme/helper** (`ai_content_cleanup.module`): `ai_content_cleanup_theme()`, `ai_content_cleanup_issue_label()`.
- Config object **`ai_content_cleanup.settings`** (install defaults ship; **no `config/schema`** file).

## Routes & permissions

| Route | Path | Permission | CSRF |
|---|---|---|---|
| `.dashboard` | `/admin/content/ai-cleanup` | `access ai content cleanup` | — |
| `.scan` | `/admin/content/ai-cleanup/scan` | `access ai content cleanup` | — |
| `.results` | `/admin/content/ai-cleanup/results` | `access ai content cleanup` | — |
| `.issue` | `/admin/content/ai-cleanup/issue/{issue_id}` | `access ai content cleanup` | — |
| `.reports` | `/admin/reports/ai-content-cleanup` | `access ai content cleanup` | — |
| `.history` | `/admin/content/ai-cleanup/history` | `access ai content cleanup` | — |
| `.editor` / `.editor_node` | `/admin/content/ai-cleanup/editor[/{node}]` | `administer ai content cleanup` | — |
| `.apply` | `/admin/content/ai-cleanup/editor/{node}/apply` | `administer ai content cleanup` | **`_csrf_token: TRUE`** |
| `.save_template` / `.save_node_template` | `/admin/content/ai-cleanup/editor[/{node}]/save-template` | `administer ai content cleanup` | **`_csrf_token: TRUE`** |
| `.bulk` | `/admin/content/ai-cleanup/bulk` | `administer ai content cleanup` | — |
| `.templates` / `.template_edit` | `/admin/content/ai-cleanup/templates[/{template_id}/edit]` | `administer ai content cleanup` | — |
| `.settings` | `/admin/config/content/ai-content-cleanup` | `administer ai content cleanup` | — |

The single content-mutating route (`.apply` → `cleanNode()`) is gated by the **restricted** admin permission and a
**CSRF token**. The bulk "Process" step in this release does not batch-apply changes (see api/pipeline.md).
