<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Acquia Cloud - Backup Manager applies a retention policy to the manual (on-demand) database backups on an Acquia Cloud environment, pruning the ones that have aged out on cron via the Acquia Cloud API.

---

Acquia Cloud takes scheduled database backups on its own schedule, but on-demand backups — the ones an operator triggers by hand before a risky deployment — accumulate on the platform until somebody removes them. This module automates that cleanup. On its settings page you pick a Cloud application, an environment and a database, choose one of two retention strategies — keep backups for a fixed number of days, or keep only the newest N — enable cron, and let Drupal's cron prune everything that falls outside the policy.

It talks to the Acquia Cloud API through the `typhonius/acquia-php-sdk-v2` library, so it needs Cloud API credentials. Credentials can be supplied two ways: as the `CLOUD_PLATFORM_API_TOKEN` / `CLOUD_PLATFORM_API_SECRET` environment variables (which Acquia Cloud provides natively), or entered on the settings form. When both environment variables are present the client uses them and the form hides the credential fields, reporting that they are set globally. The module only ever acts on backups whose type is `ondemand`, and it deliberately never deletes the last remaining backup, so a misconfigured limit cannot wipe out an environment's backup history entirely.

Retention runs only in `hook_cron()` and only when `cron_enabled` is switched on, so installing the module does not by itself start removing anything. If you run Acquia Site Factory (ACSF), use the sibling `acsf_backup_manager` module instead.

---

- Prune on-demand Acquia Cloud database backups automatically on cron.
- Keep on-demand backups for a fixed number of days (`time_to_keep`).
- Keep only the newest N on-demand backups (`number_to_keep`).
- Switch between the two retention strategies with the "Keep backup options" selector.
- Target a specific Cloud application, environment and database.
- Load application, environment and database lists live from the Cloud API in the settings form.
- Supply Cloud API credentials as `CLOUD_PLATFORM_API_TOKEN` / `CLOUD_PLATFORM_API_SECRET` environment variables.
- Let the form auto-hide credential fields when those environment variables are set.
- Enter credentials on the settings form when environment variables are not available.
- Enable cron-driven deletion deliberately — it is opt-in via `cron_enabled`.
- Rely on the built-in safeguard that the last remaining backup is never deleted.
- Log which backup UUIDs were deleted (and when) after each cron run.
- Restrict who can reach the settings page via `administer site configuration`.
- Generate a Cloud API key/secret per the Acquia Cloud documentation.
- Review the retention limit before enabling cron so you keep enough history.
- Understand that Acquia's scheduled backups are not managed by this module.
- Use `acsf_backup_manager` instead on Acquia Site Factory (ACSF).
- Read the module README as in-app help (rendered via the Markdown filter if present).
- Operate against the on-demand backups only — automatic/scheduled backups are left untouched.
