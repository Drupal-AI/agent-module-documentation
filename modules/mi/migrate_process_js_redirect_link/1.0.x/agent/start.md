<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Process JS Redirect Link (migrate_process_js_redirect_link) — agent index

**Migrate process plugin: fetches a URL and extracts the target link from a JS-redirect page.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^8 || ^9 || ^10 || ^11
- **Depends:** migrate
- **Plugin id:** `migrate_process_js_redirect_link` (used in migration YAML).
- **Service:** `...MigrateProcessJsRedirectLink` (args `@http_client`, logger channel).
- **Security:** developer tool, no routes/UI; issues a server-side Guzzle GET to a **migration-config-supplied** URL (SSRF surface, but not request-driven); input validated as absolute http(s) URL; Guzzle TLS defaults (verification on).

See [api/plugin.md](api/plugin.md).
