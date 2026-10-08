<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupitor Client exposes a token-authenticated JSON endpoint that reports available Composer package updates for a Drupal site to the external Drupitor monitoring service.

---

Drupitor Client is the site-side companion to the Drupitor SaaS. When enabled and configured, it publishes a single read-only endpoint at `/drupitor/api/v1/updates` that runs Composer on the server (`composer show --latest`, via PHP `proc_open()`) to build an inventory of every installed package with its current version, latest available version, and an "is outdated" flag. That inventory is AES-encrypted with a key shared with the Drupitor host and returned as JSON, so the Drupitor service can track update and security-update status for many sites centrally. The endpoint is protected by a custom access check that validates a shared API token (Authorization header, `X-API-Token` header, or `token` query parameter) with a timing-safe comparison. The module ships disabled by default and depends only on core System and User; it requires a Composer-based Drupal install with the Composer binary reachable and `proc_open()` available. All operations are logged to the `drupitor_client` channel for auditing.

---

- Report available Composer/module updates for a Drupal site to the Drupitor monitoring SaaS.
- Centrally monitor update status across many Drupal sites from one Drupitor dashboard.
- Track which installed packages are outdated (current vs. latest version) without shell access to each site.
- Surface pending security updates as part of a fleet-wide update-monitoring workflow.
- Expose the update inventory over HTTP so an external service can poll it on a schedule.
- Authenticate the polling service with a shared API token supplied via a request header (recommended).
- Authenticate via the `Authorization: Bearer <token>` header for standard HTTP clients.
- Authenticate via a custom `X-API-Token` header where Bearer is inconvenient.
- Authenticate via a `token=` query parameter for compatibility with simple clients (discouraged; can leak into logs).
- Encrypt the transmitted package inventory end-to-end with AES-256-GCM (recommended) or AES-256-CBC.
- Keep the endpoint completely inert until an administrator explicitly enables it.
- Require both a configured API token and a configured encryption key before the endpoint returns data.
- Point the module at a specific Composer executable path when `composer` is not on the system `PATH`.
- Bound Composer command runtime with a configurable timeout (10–300 seconds) so a stuck command cannot tie up the server.
- Audit every endpoint access, denial, and Composer run via the `drupitor_client` log channel (Reports → Recent log messages).
- Detect misconfiguration early through `hook_requirements()` checks (Composer availability, token configured, project structure, enabled status) on the status report.
- Manage all settings from the admin form at Configuration → Development → Drupitor Client, gated by the `administer drupitor client` permission.
- Manage secrets outside the database by overriding `drupitor_client.settings` values in `settings.php` per environment.
- Disable the endpoint again at any time (without uninstalling) to instantly block access to update information.
