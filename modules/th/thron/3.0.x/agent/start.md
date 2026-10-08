<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# THRON (thron) — agent index

**Integrates the THRON DAM: search/embed/upload THRON assets from Drupal via Entity Browser, CKEditor 5, and a media source.**

- **Version:** 3.0.x
- **Core:** ^9 || ^10 || ^11 · **Package:** Media
- **Config route:** `/admin/config/services/thron` (`THRONConfigurationForm`) — `administer thron configuration` (`restrict access: TRUE`)
- **Editor routes:** `/thron_autocomplete/{tags,categories,languages}/…`, `/thron/upload/chunk`, `/thron/upload/finalize` — all require `thron search media`
- **Permissions:** `administer thron configuration`, `thron search media`, `thron upload media`
- **Key service:** `thron_api` (`THRONApi`) with `cache.thron` bin; helpers `Thronintegration_{Api,HTTP,Utils}`
- **Deps:** media, ckeditor5, entity_embed, entity_browser, media_entity_browser(_media_library), jquery_ui_autocomplete, inline_entity_form
- **Security:**
  - **TLS ON** — `THRONApi` Guzzle calls use `'verify' => TRUE` (lines 1416/1634/1716/1809/1852/1895/2050/2129); the `CURLOPT_SSL_VERIFY*` lines in `Thronintegration_HTTP.php:80-81` are COMMENTED OUT (cURL secure defaults apply). No active disabled-TLS.
  - **No user-controlled SSRF** — outbound URLs come from configured THRON endpoints and THRON-issued S3 creds, not request params.
  - Admin config gated + restricted; editor autocomplete/upload routes gated by `thron search media`.

See [configure/setup.md](configure/setup.md) and [api/thron_api.md](api/thron_api.md)