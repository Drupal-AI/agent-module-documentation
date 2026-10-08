<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Content Cleanup — settings, permissions, config

## Install & enable

```bash
composer require drupal/ai_content_cleanup
drush en ai_content_cleanup -y
```

Depends on core **`node`** and **`text`**. `hook_schema()` (`ai_content_cleanup.install`) creates two tables on
install: `ai_content_cleanup_issue` and `ai_content_cleanup_history`.

## Permissions (`ai_content_cleanup.permissions.yml`)

| Permission | Restricted | Grants |
|---|---|---|
| `access ai content cleanup` | no | View the dashboard, scan, results, issue, reports and history pages. |
| `administer ai content cleanup` | **yes** (`restrict access: true`) | The editor, apply-changes, save-template, bulk, templates and settings pages. |

`access ai content cleanup` is not a restricted permission — it is the "viewer/reviewer" grant; everything that
changes a node or the configuration requires the restricted `administer ai content cleanup`.

## Settings form (`Form\SettingsForm`)

Route `ai_content_cleanup.settings`, path **`/admin/config/content/ai-content-cleanup`**, permission
`administer ai content cleanup`. `ConfigFormBase` editing config object **`ai_content_cleanup.settings`**.
Install defaults are in `config/install/ai_content_cleanup.settings.yml`:

```yaml
enabled_rules:
  broken_html: true
  inline_styles: true
  heading_hierarchy: true
  accessibility: true
  empty_elements: true
  deprecated_markup: true
scan_content_types:
  article: article
  page: page
auto_apply_low_risk: false
preserve_original: true
heading_start_level: 2
batch_size: 25
```

| Key | Type | Meaning |
|---|---|---|
| `scan_content_types` | checkboxes | Node bundles included in scans/counts (options come from `entity_type.bundle.info` for `node`). |
| `enabled_rules` | checkboxes | Which of the six rules are active: `broken_html`, `inline_styles`, `heading_hierarchy`, `accessibility`, `empty_elements`, `deprecated_markup`. |
| `auto_apply_low_risk` | checkbox | Stored, but not consulted by the processor in this release (no auto-apply path is wired up). |
| `preserve_original` | checkbox | Stored; `cleanNode()` always creates a new revision regardless. |
| `heading_start_level` | number 1–6 | First heading level used by `normalizeHeadings()`. |
| `batch_size` | number 1–200 | Row limit passed to `scanContent()` from the scan page. |

`submitForm()` `array_filter`s the two checkbox sets before saving. **No `config/schema`** ships for this object,
so strict config-schema validators may warn; values still save.

## Cleanup "templates" (rule presets)

`Form\TemplateForm` (route `ai_content_cleanup.template_edit`, `/admin/content/ai-cleanup/templates/{id}/edit`,
`administer ai content cleanup`) edits named rule presets. Templates are **not entities or config** — they are
stored in State under `ai_content_cleanup.custom_templates` (seeded with four defaults on first read by the
controller/form). `saveTemplate` (from the editor) appends the currently enabled rules as a new template; the form
edits name/description/tags/rules. Fields are plain text and rendered escaped by Twig.

## Config summary

- Config object: `ai_content_cleanup.settings` (install defaults, no schema).
- State keys: `ai_content_cleanup.custom_templates`.
- DB tables: `ai_content_cleanup_issue`, `ai_content_cleanup_history` (see [api/pipeline.md](../api/pipeline.md)).
- No Drush commands, no external HTTP, no API keys.
