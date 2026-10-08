<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Voiceflow (voiceflow) — agent index
**Embeds the Voiceflow chatbot widget site-wide by project ID (with path exclusions); the `voiceflow_index` submodule serves a public content feed at `/voiceflow.xml`.**

- **Version:** 1.1.x (release 1.1.0)
- **Core:** ^10 || ^11
- **Dependencies:** system (base); submodule adds node, language, datetime.
- **Route:** `voiceflow.settings` → `/admin/config/system/voiceflow`, permission `administer site configuration`.
- **Attach:** `hook_page_attachments` adds `voiceflow/voiceflow` library + `drupalSettings.voiceflow.project_id` when enabled and path not excluded.
- **Submodule `voiceflow_index`:** settings at `/admin/config/system/voiceflow/index` (`administer site configuration`); `/voiceflow.xml` route with `_access: 'TRUE'`.
- **Security:** admin forms gated by `administer site configuration`. `/voiceflow.xml` is intentionally public and SOUND — a read-only sitemap-style feed whose query is restricted to `status = 1` + `accessCheck(TRUE)`, exposing only published, access-checked nodes. No mutating endpoints, no outbound requests from Drupal, no secrets.

See [configure/settings.md](configure/settings.md)
