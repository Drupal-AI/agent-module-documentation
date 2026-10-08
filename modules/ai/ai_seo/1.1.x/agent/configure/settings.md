<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Global settings & permissions

## Prerequisite: the AI module

`ai_seo` depends on `drupal/ai`. Before it can run you must configure an AI provider at
`/admin/config/ai/providers`, then pick the provider+model for SEO at `/admin/config/ai/seo`.
Generating a report calls that provider's API and **incurs usage costs**.

## Settings config object `ai_seo.settings`

Form route `ai_seo.settings` at `/admin/config/ai/seo` (permission `administer ai seo`).
Schema is a `config_object`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `provider_and_model` | string | `''` | selected AI provider+model id used for analysis |
| `custom_system_prompt` | text | `''` | optional system prompt prepended to every analysis |
| `custom_prompt` | text | `''` | optional extra prompt text applied to every analysis |
| `enable_field_buttons` | bool | `false` | show inline "SEO/GEO ✦" buttons on text field widgets |

```bash
drush cget ai_seo.settings
drush cset ai_seo.settings enable_field_buttons true -y
drush cset ai_seo.settings provider_and_model 'openai__gpt-4o' -y
```

## Permissions (`ai_seo.permissions.yml`)

| Permission | Gates |
|---|---|
| `view seo reports` | viewing saved reports, the "Analyze SEO" operation/contextual link, the node-form sidebar |
| `create seo reports` | actually generating a report (calls the AI provider — costs money) |
| `administer ai seo` | the global settings form |
| `administer ai seo settings` | managing `ai_seo_report_type` entities (admin_permission of the entity) |

Manage at `/admin/people/permissions/module/ai_seo`.
