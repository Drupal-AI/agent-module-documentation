<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI SEO/GEO analyzer — agent index

Sends a node's rendered HTML to an LLM (via the **AI** module) and stores an SEO/GEO audit
per node. Requires `drupal/ai` configured with a provider. Analysis prompts are **config
entities** you can add/edit/disable without touching code.

- **Global settings, provider/model, permissions** → [configure/settings.md](configure/settings.md)
- **Report types (the `ai_seo_report_type` config entity) — the 8 shipped + adding your own** →
  [configure/report-types.md](configure/report-types.md)
- **Services, DB table, queue worker, routes & node integration** → [api/reports.md](api/reports.md)

Key facts:
- Settings config: `ai_seo.settings` → `provider_and_model`, `custom_system_prompt`,
  `custom_prompt`, `enable_field_buttons`. Route `ai_seo.settings` at `/admin/config/ai/seo`.
- Report type config entity: type id `ai_seo_report_type`, config prefix `report_type`
  (config names `ai_seo.report_type.<id>`), fields `id, label, description, prompt, status,
  default_prompt_hash`. Collection at `/admin/config/ai/seo/report-types`.
- 8 shipped report types: `full`, `topic_authority`, `natural_language`, `link_analysis`,
  `headings_and_structure`, `schema_org_markup`, `ai_citability`, `agentic_readiness`.
- Reports saved in the `ai_seo` DB table; viewed at `/node/{node}/seo`. Background queue worker
  `ai_seo_analysis`. Services `ai_seo.service`, `ai_seo.report_service`.
- No Drush commands. Generating a report calls the external AI provider (costs money).
