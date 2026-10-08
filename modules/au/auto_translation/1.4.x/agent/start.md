<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Translation — agent index

Adds a Translate button (and two bulk Actions) that machine-translate content entities into the
site's other languages via a pluggable provider (Google / DeepL / LibreTranslate / Amazon / Drupal
AI). Builds on core `content_translation`. Config UI `auto_translation.settings`
(`/admin/config/system/auto-translation`). Two permissions, both `restrict access: true`.

- **Providers, all config keys, permissions, and the two bulk Action plugins** →
  [configure/settings.md](configure/settings.md)
- **The `auto_translation.utility` service: `translate()`, per-provider calls, `formTranslate()`,
  key handling** → [api/translate.md](api/translate.md)

Key facts:
- Provider endpoints are fixed in code (no user-supplied URL): Google free
  (`translate.googleapis.com/translate_a/single`), Google server (`google/cloud-translate`), DeepL
  (`{api-free|api}.deepl.com/v2/translate`), LibreTranslate (`libretranslate.com/translate`),
  Amazon Translate SDK, Drupal AI (`ai.provider`).
- Config object `auto_translation.settings`; API keys stored via `encryptApiKey()` (not plaintext).
- Entry points: `hook_form_alter` on node/media/block/taxonomy add forms → `Utility::formTranslate()`;
  Action plugins `auto_translation_bulk_auto_translate_publish_action` /
  `..._draft_action`.
- Permissions: `administer auto_translation module`, `auto translation translate content` (both restricted).
