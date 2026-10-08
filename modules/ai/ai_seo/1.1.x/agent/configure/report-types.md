<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Report types (`ai_seo_report_type` config entity)

Each analysis is driven by a **report type** config entity — this is the module's main
configurable surface and needs no AI call to inspect or edit.

- Entity type id: `ai_seo_report_type`
- Config prefix: `report_type` → config object names are `ai_seo.report_type.<id>`
- Admin permission: `administer ai seo settings`
- Managed at `/admin/config/ai/seo/report-types` (add / edit / delete forms under it)

## Exported fields (`config_export`)

| Field | Notes |
|---|---|
| `id` | machine name (e.g. `full`) |
| `label` | human name shown in the UI |
| `description` | short description |
| `prompt` | the full LLM prompt text sent with the page HTML |
| `status` | boolean enable/disable; disabled types are not offered |
| `default_prompt_hash` | md5 of the shipped default prompt; `md5(prompt) !== default_prompt_hash` means an admin has customized it (never written by the edit form) |

## The 8 shipped report types

`full` (Full SEO Analysis), `topic_authority`, `natural_language`, `link_analysis`,
`headings_and_structure`, `schema_org_markup`, `ai_citability` (AI Mode & GEO citability),
`agentic_readiness`. All ship with `status: true`. The default report used by the queued
after-save analysis is `full`.

## Inspect / manage from the CLI

```bash
# List all report types:
drush php:eval 'print implode("\n", array_keys(\Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->loadMultiple()));'

# Read one:
drush cget ai_seo.report_type.full

# Disable a report type so it is no longer offered:
drush php:eval '$e=\Drupal::entityTypeManager()->getStorage("ai_seo_report_type")->load("link_analysis"); $e->set("status",FALSE)->save();'
```

## Add a custom report type in code

```php
use Drupal\ai_seo\Entity\ReportType;
ReportType::create([
  'id' => 'my_audit',
  'label' => 'My Custom Audit',
  'description' => 'Focused audit for my needs.',
  'prompt' => 'Assume the role of an SEO expert and analyze the following HTML …',
  'status' => TRUE,
])->save();
```

Getter/setter methods on the entity: `getDescription()/setDescription()`,
`getPrompt()/setPrompt()`, `getDefaultPromptHash()/setDefaultPromptHash()`.
