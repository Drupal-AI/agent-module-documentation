<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Apostroph Group Translator (tmgmt_apostrophgroup_provider) — agent index

**TMGMT translator plugin that sends XLIFF/ZIP jobs to the Apostroph Group REST service and imports deliveries.**

- **Version:** 8.x-2.x (8.x-2.3)
- **Core:** ^10 || ^11
- **Dependencies:** tmgmt, tmgmt:tmgmt_file
- **Plugin:** `@TranslatorPlugin` id `tmgmt_apostrophgroup_provider` (`ApostrophTranslator`, UI `ApostrophTranslatorUI`)
- **REST client:** Swagger-generated `TranslationApi` / `ServiceStatusApi` (Guzzle, HTTP Basic auth)
- **Cron:** `tmgmt_apostrophgroup_provider_cron` pulls finished deliveries per translator
- **Settings:** `apostroph-settings` (url/username/password/customer_id), `one_export_file`, `scheme` (default `public`), `is_confidential`, `cron-settings`

**Security:** Outbound-only (plus cron polling) — no inbound webhook/callback route, nothing anonymous. TLS verification uses Guzzle's secure default (no `verify=>false`). Report items: (1) provider username/password stored plaintext in the `tmgmt_translator` config entity (`.module` `setPassword`); (2) default `scheme` = `public`, so exported source ZIP/XLIFF and the surfaced download link are world-readable — use `private` for confidential jobs.

See [configure/provider.md](configure/provider.md).
