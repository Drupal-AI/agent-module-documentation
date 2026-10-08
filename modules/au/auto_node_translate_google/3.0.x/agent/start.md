<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Node Translate Google (auto_node_translate_google) — agent index
**Google Cloud Translation v3 provider plugin for Auto Node Translate, with glossary support.**

- **Version:** 3.0.x
- **Core:** ^10.2 || ^11
- **Requires:** auto_node_translate
- **Plugin:** `GoogleTranslationApi` (`@AutoNodeTranslateProvider`, id `auto_node_translate_google`)
- **Route:** `auto_node_translate_google.settings` → `/admin/config/regional/google` (`_permission: administer site configuration`)
- **Config:** `auto_node_translate_google.settings` — `google_credentials` (managed file), `google_api_project`, `google_location`, per-language `google_api_glossary_mappings_*`, `case_sensitive`
- **Security:** Settings gated by `administer site configuration`. Service-account JSON uploaded to `private://` (not public), `json`-only. Uses official Google Cloud PHP SDK; no `verify => false` in module code.

See [configure/google.md](configure/google.md)