<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, report types, routes & permissions

## Install & enable

```bash
composer require drupal/ai_content_advisor
drush en ai_content_advisor -y
drush cr
```

Requires the **AI module** (`ai`) with a configured chat provider, and the `league/commonmark`
library (pulled by Composer). Enabling installs the DB table `ai_content_advisor` (`.install`,
`hook_schema`) and the five default report-type config entities from `config/install/`.

## Module settings — `ConfigurationForm`

Route **`ai_content_advisor.settings`** → `/admin/config/ai/content-advisor` (permission
**`administer ai content advisor`**; menu under *ai.admin_settings*). Config object edited:
**`ai_content_advisor.configuration`**.

| Field | Config key | Notes |
|---|---|---|
| Provider and Model | `provider_and_model` | `"<provider>__<model>"` string, from `aiProviderManager->getSimpleProviderModelOptions('chat')`. Split on `__` at analysis time; must yield exactly 2 parts or analysis throws. |
| System prompt (custom) | `custom_system_prompt` | Optional. Overrides the built-in default system prompt (`AiContentAdvisorAnalyzer::getDefaultSystemPrompt()`). |

There is **no `config/install` file** for `ai_content_advisor.configuration`; it is created on first
save. (`.install` update `10304` clears a deprecated `custom_prompt` key.)

## Report types — `AiContentAdvisorReportType` config entity

Config entity type **`ai_content_advisor_report_type`** (`config_prefix: report_type`,
`admin_permission: administer ai content advisor report types`), schema
`config/schema/ai_content_advisor_report_type.schema.yml`. Exported keys: `id`, `label`,
`description`, `prompt`, `status`. `preSave()` munges the id to `[a-z0-9_]`.

Managed at:

- `entity.ai_content_advisor_report_type.collection` — `/admin/config/ai-content-advisor/report-types`
- `.add_form` / `.edit_form` / `.delete_form` — `…/report-types/add`, `…/{id}/edit`, `…/{id}/delete`

All four report-type routes require permission **`administer ai content advisor report types`**
(the `_admin_route`). Add/edit uses `Form\AiContentAdvisorReportTypeForm`; delete uses core
`EntityDeleteForm`; listing uses `AiContentAdvisorReportTypeListBuilder`.

Config-installed defaults (`config/install/ai_content_advisor.report_type.*.yml`): **`full`**,
**`topic_authority`**, **`natural_language`**, **`link_analysis`**, **`headings_and_structure`** —
each carrying an SEO/content-analysis `prompt`.

## The report page — route & access

Route **`entity.node.content_analyzer`** → `/node/{node}/content-advisor`, permission
**`view ai content advisor reports`**, `node` upcast as `entity:node` (`_admin_route`). The
controller `AnalyzeContentController::printReport()` just renders `Form\AnalyzeNodeForm`.

Within that form, the **"Create a New Content Analysis Report"** section is `#access`-gated on
`create ai content advisor reports` — viewers without it see existing reports but cannot generate
new ones (which incur provider cost).

Node links to this page are added by `.module` hooks — `hook_entity_operation`,
`hook_contextual_links_view_alter` — and each first checks `view ai content advisor reports`.

## Permissions (`ai_content_advisor.permissions.yml`)

| Permission | Grants |
|---|---|
| `view ai content advisor reports` | View reports and see the "Analyze Content with AI" links/tab. |
| `create ai content advisor reports` | Generate new reports (uses the selected AI model — incurs API cost). |
| `administer ai content advisor` | The settings form. |
| `administer ai content advisor report types` | Create/edit/delete report types. |

## Block

`ai_content_advisor_advanced_report_block` (admin label *"AI Content Advisor Advanced Report"*,
context `entity:node`) embeds `AnalyzeNodeForm` for the contextual node and sets
`#access = view ai content advisor reports` with a `node:{id}` cache tag.
