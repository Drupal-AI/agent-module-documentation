<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TMGMT Translator Supertext AI (tmgmt_supertext_ai) — agent index

**Supertext AI provider plugin for TMGMT — submits job items to the Supertext translation API and writes back translations.**

- **Version:** 1.0.x  (info.yml `1.0.2`)
- **Core:** ^9 || ^10 || ^11
- **Depends on:** tmgmt
- **Plugin:** `@TranslatorPlugin("supertext_ai")` — `src/Plugin/tmgmt/Translator/SupertextAITranslator.php`
- **UI class:** `src/SupertextAITranslatorUi.php` (config form + credential validation)
- **Data chunker:** `src/SupertextAiData.php` (10 000-char chunks, html tag handling)
- **Config settings:** `api_key`, `api_server`, `api_server_other` (schema in `config/schema/`)

**Security:** No custom routes or permissions; configuration is done through TMGMT's admin translator forms (permission-gated by TMGMT). HTTPS requests use Guzzle with default TLS verification (no `verify => false`). The API key is stored as a plain string in the translator config entity (standard TMGMT storage, not a Key entity) and is sent in the `Authorization: Supertext-Auth-Key` header — treat exported/staged config as secret. The "Other" server option accepts an admin-supplied URL to which the key is sent (admin-trusted). No verify-disable, unverified callback, or SQL surface.

See [configure/setup.md](configure/setup.md)
