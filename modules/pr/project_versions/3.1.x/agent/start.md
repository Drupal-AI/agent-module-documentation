<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Project Versions — agent index

Exposes installed PHP + contrib module/theme versions (with lifecycle info) as JSON so an
external service can track available updates. Fork of System Status. No dependencies, no
permissions file, no Drush, no plugin types. `configure` route:
`project_versions.admin_settings` (`/admin/config/system/project-versions`).

- **The three routes, the JSON payload, the token/encryption model, config keys & overrides** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Routes (`project_versions.routing.yml`): `project_versions.status_page`
  `/admin/reports/project-versions` (perm `administer site configuration`, plain JSON);
  `project_versions.status_page_encrypted` `/admin/reports/project-versions/{urlToken}`
  (custom access — token must equal stored `project_versions_url_token`, returns AES ciphertext);
  `project_versions.admin_settings` (settings form, perm `administer site configuration`).
- `hook_install` generates random `project_versions_url_token` and
  `project_versions_encryption_key` (`Crypt::randomBytesBase64(16)`), stored in
  `project_versions.settings`. Settings form shows both read-only (disabled fields).
- Encryption: AES-128-CBC, key = `hash('SHA256', encryption_key)`, random IV, base64(iv+ct)
  (`ProjectVersionsEncryption::encryptOpenssl`).
- Report built by `ProjectVersionsController::data()`: `php_version` + `core`/`contrib`/`theme`
  version maps from each extension's `.info.yml`; core & field-type packages skipped.
