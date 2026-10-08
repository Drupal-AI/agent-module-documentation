<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Project Versions exposes a JSON report of the installed PHP version plus every contrib module/theme and its version (with lifecycle info), so an external monitoring service can track available updates across many Drupal sites from one place.

---

A fork of the System Status module, simplified and hardened for Drupal 10+. It adds three
routes served by `ProjectVersionsController`: a plain JSON report at
`/admin/reports/project-versions` (permission `administer site configuration`), an
**encrypted** JSON report at `/admin/reports/project-versions/{urlToken}` guarded by a
custom-access token check, and a settings page at `/admin/config/system/project-versions`.
The report (`data()`) walks the module and theme handlers, reads each extension's `.info.yml`,
skips core/field-type packages, and returns `php_version` plus `core`, `contrib`, and `theme`
version lists including `lifecycle`/`lifecycle_link` where present. On install
(`hook_install`) the module generates two random 16-byte base64 tokens via
`Crypt::randomBytesBase64()` — a `project_versions_url_token` (the shared secret embedded in the
encrypted URL) and a `project_versions_encryption_key`. The encrypted endpoint AES-128-CBC
encrypts the JSON with a SHA-256 hash of that key and a random IV (`ProjectVersionsEncryption::encryptOpenssl`),
so a remote collector that knows the URL token receives ciphertext it decrypts with the shared
key. The settings form only **displays** the two generated values (both fields are disabled);
there is no UI to change them. No permissions module file, no Drush, no plugin types.

---

- Report installed contrib module and theme versions as JSON for an external dashboard.
- Monitor available updates across many Drupal sites from a single central service.
- Expose the PHP version of each site to a fleet-monitoring tool.
- Include module lifecycle status (e.g. deprecated/obsolete) in an upgrade audit.
- Let an off-site collector poll each site on a schedule via the encrypted token URL.
- Keep the version report confidential in transit by using the AES-encrypted endpoint.
- Give a trusted admin a quick JSON overview at `/admin/reports/project-versions`.
- Feed a custom update-status dashboard without Drupal's own update.module UI.
- Track which sites are behind on releases across a hosting estate.
- Integrate Drupal version data into an external CMDB or asset inventory.
- Detect end-of-life contrib projects across sites via the lifecycle fields.
- Replace the deprecated System Status module with a maintained fork.
- Retrieve the generated URL token and encryption key from the settings page to configure a collector.
- Provide machine-readable version data to a CI/CD or security-scanning pipeline.
- Compare installed versus latest versions in a downstream tool.
- Audit theme versions alongside module versions in one payload.
- Build alerting when a site drifts from an approved module baseline.
- Serve the report to automation without granting a login (token URL only).
- Override the generated token/key per environment via `settings.php` config overrides.
- Distinguish contrib projects from core automatically (core packages are filtered out).
