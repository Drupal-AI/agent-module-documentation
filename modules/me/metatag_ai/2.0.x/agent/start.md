<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Metatag AI Generator — agent index

Adds a "Generate Metatag" button to node forms that asks an AI provider (via the `ai` module) to
write meta title/description/abstract/keywords from the node's title+body and AJAX-populates the
Metatag field. Depends on `metatag` and `ai`. Config route `metatag_ai.content_settings`
(`/admin/config/content/metatag-ai`). No config schema, no Drush.

- **Settings form, config keys, provider selection, per-language prompts** →
  [configure/settings.md](configure/settings.md)
- **The `metatag_ai.generator` service: `generate()` / `bulkGenerate()`, prompt & JSON handling** →
  [api/generator.md](api/generator.md)
- **The two permissions and what they gate** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Button appears only when: an active AI chat provider exists, the node's type is selected, and the
  current user has `administer metatag content` (`metatag_ai.module` `metatag_ai_form_alter`).
- Generation is a service call → JSON parse → AJAX `InvokeCommand` into `#edit-<field>-0-basic-*`;
  the editor still saves the node. `bulkGenerate()` writes the field itself.
- All settings live in `metatag_ai.content_settings` (content types, `metadata_field_id`,
  `provider_model`, `system_prompts`, `system_messages`). Default field name `field_metatag`.
- Requires an AI provider configured at `/admin/config/ai`; otherwise the button is hidden and the
  service returns FALSE with a logged error.
