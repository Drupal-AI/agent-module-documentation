<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Guardian — agent index

Exposes a site's status report + enabled-project/update info as key-protected JSON for central
monitoring. Depends on core `update`. Config UI `site_guardian.form`
(`/admin/config/development/site_guardian`, `administer site configuration`).

- **Settings (key, activation, notes), the access model, admin routes** →
  [configure/settings.md](configure/settings.md)
- **The JSON endpoints + `hook_site_guardian_status()`** → [api/endpoints.md](api/endpoints.md)

Key facts:
- Endpoints `/site_guardian/status_report` and `/site_guardian/enabled_modules_and_updates` are
  `_custom_access` → require `site_guardian_key` query param == stored key (`hash_equals`) **and**
  the module activated. Flood-limited 10 failed attempts/hour/IP; `no_cache: TRUE`.
- Key auto-generated on install (`Crypt::randomBytesBase64(55)`); re-enabling resets it.
- No hardcoded/default secret; the key is the credential (send over HTTPS).
