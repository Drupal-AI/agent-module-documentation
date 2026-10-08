<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes and the report View

## Install & enable

```bash
composer require drupal/analyze_ai_brand_voice
drush en analyze_ai_brand_voice -y
```

Pulls in `analyze` (>=1.3.0), `ai`, `views_color_scales` (>=1.1.0). `hook_install()` in
`analyze_ai_brand_voice.install` creates the `analyze_ai_brand_voice_results` table.
There is **no chat provider bundled** — configure one in the AI module first
(`/admin/config/ai/providers`) and set a default **chat** provider/model, or every analysis
returns NULL (a "No chat AI provider is configured" status table is shown instead of a gauge).

## Turn analysis on

Three steps (the module does not analyse anything until a bundle is opted in):

1. Set a default chat provider in the **AI** module.
2. Write guidelines at **`/admin/config/analyze/brand-voice`**.
3. Enable the *AI Brand Voice Analysis* analyzer per entity type/bundle at
   **`/admin/config/content/analyze-settings`** (this writes `analyze.settings:status`, owned by
   the base Analyze module). `_analyze_ai_brand_voice_is_supported_entity()` checks
   `status[$entity_type][$bundle]['brand_voice_analyzer']` before wiping scores on entity
   update/delete.

## The settings form

`BrandVoiceSettingsForm` (`src/Form/BrandVoiceSettingsForm.php`), a `ConfigFormBase`.

- Route **`analyze_ai_brand_voice.settings`** → path `/admin/config/analyze/brand-voice`,
  requirement **`_permission: 'administer analyze'`** (routing.yml). Menu link parented under
  `ai.admin_settings`; a local task "Settings"; form id `analyze_ai_brand_voice_settings`.
- One field: **`brand_voice`** (textarea, required). Saved trimmed. On submit it calls
  `BrandVoiceStorageService::invalidateConfigCache()`, deleting every cached row whose
  `config_hash` no longer matches — so changing the guidelines forces a re-analysis.
- If `ckeditor_ai_agent` is installed and has a `brand_voice` set, `getDefaultBrandVoice()` seeds
  the field default from `ckeditor_ai_agent.settings`; otherwise the default is
  `'Clear, approachable, professional, respectful'`.
- With `access site reports` the form shows a "View reports" button to the report View.

## Config object + schema

Config object **`analyze_ai_brand_voice.settings`**:

```yaml
# config/install/analyze_ai_brand_voice.settings.yml
brand_voice: 'Clear, approachable, professional, respectful'
```

Schema (`config/schema/analyze_ai_brand_voice.schema.yml`): `config_object` with one `text`
mapping, `brand_voice`. That single string is the entire configuration surface.

Read at runtime by `AIBrandVoiceAnalyzer::getBrandVoice()` and
`BrandVoiceStorageService::generateConfigHash()`, both falling back to the same default string when
empty.

## The bundled report View

`config/install/views.view.ai_brand_voice_analysis.yml`, id **`ai_brand_voice_analysis`**,
base table `analyze_ai_brand_voice_results`.

- Page display `page_1` at **`/admin/reports/brand-voice-analysis`** (admin menu under Reports).
- **Access: permission `view analyze results`** (a base Analyze permission — this module defines
  none). The settings-form "View reports" link and the View's own
  `hook_views_pre_view()` "Configure settings" button are gated by `access site reports` /
  `administer analyze` respectively.
- Columns: title (link to content), **score** rendered with the `numeric_color_scale` plugin
  (Views Color Scales), content type, created, last edited, last analyzed. Exposed filters for
  language and content type were added by update hooks 8002/8003.
- `hook_views_color_scale_popover_alter()` in the `.module` swaps the score popover for an
  `analyze_gauge` themed as Off-brand / Neutral / On-brand.

## Views data

`analyze_ai_brand_voice.views.inc` exposes every column of `analyze_ai_brand_voice_results`
(id, entity_type, entity_id with a **relationship to `node_field_data`**, entity_revision_id,
langcode, score as float, content_hash, config_hash, analyzed_timestamp as date) so you can build
custom reports.

## Update hooks (in `.install`)

- **8001** — renames the analyzer plugin id `brand_voice_analyzer` → `analyze_ai_brand_voice_analyzer`
  inside `analyze.settings:status`.
- **8002 / 8003** — add language and content-type exposed filters, `created` / `analyzed_timestamp`
  fields, and time-ago formatting to the report View.
