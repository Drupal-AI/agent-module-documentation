<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, routes & config

Config object: **`paragraphs_report.settings`** (schema `config/schema/paragraphs_report.schema.yml`).
Settings form `Form\SettingsForm` at `/admin/reports/paragraphs-report/settings`
(route `paragraphs_report.settings`, permission `administer paragraphs_report configuration`).

## Config keys + defaults (`config/install`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `content_types` | sequence (checkboxes) | `{}` | Node types to scan/report on. Stored as `machine => machine` (0 = unchecked). |
| `hide_paras` | sequence (checkboxes) | `{}` | Paragraph types to hide from the report's filter dropdown. |
| `import_rows_per_batch` | integer | `10` | Nodes processed per batch when rebuilding the report. |
| `watch_content` | boolean | `0` | When TRUE, node insert/update/delete automatically updates the report data. |

## Routes (`paragraphs_report.routing.yml`)

| Route | Path | Permission |
|---|---|---|
| `paragraphs_report.report` (**configure**) | `/admin/reports/paragraphs-report` | `access paragraphs report` |
| `paragraphs_report.settings` | `/admin/reports/paragraphs-report/settings` | `administer paragraphs_report configuration` |
| `paragraphs_report.data` | `/admin/reports/paragraphs-report/update` | `update report data` |
| `paragraphs_report.export` | `/admin/reports/paragraphs-report/export` | `access paragraphs report` |

## Read / set via drush

```bash
drush config:get paragraphs_report.settings

# Report on the article content type and auto-update on node changes:
drush php:eval '\Drupal::configFactory()->getEditable("paragraphs_report.settings")
  ->set("content_types", ["article" => "article"])
  ->set("watch_content", TRUE)->save();'

drush config:set paragraphs_report.settings import_rows_per_batch 25 -y
```

Note: `content_types` is a checkbox map — an included type is `"<type>": "<type>"` (a value equal to its
key is "checked"; `0` is unchecked). After changing which content types are selected, run
`drush paragraphs_report:update` to (re)build the actual report data (see [drush/commands.md](../drush/commands.md)).
The report **data** itself is not in this config — it lives in the key-value store (see
[api/service.md](../api/service.md)).
