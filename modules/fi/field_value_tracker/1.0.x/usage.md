<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Field Value Tracker tracks and changes field values between different environments.

---

Field Value Tracker **tracks and swaps field values between environments** — its stated use case is providing
different values (e.g. **login URLs and email addresses**) for the same fields across dev/stage/production, so an
environment shows environment-appropriate values. It depends on core Field, Options and System, and provides its
own permissions.

Use it to manage environment-specific field values. It is an administration/deployment tool. Security/data
handling: because it manages per-environment values like **login URLs and email addresses**, treat those values as
sensitive configuration — restrict the tracking permission to trusted admins, avoid pointing production values at
non-production endpoints (or vice versa), and keep any secret-adjacent values out of exported config. It has no
access-control role beyond its permission. Configure the tracked fields and environment values.

---

- Track field values across environments.
- Swap values per environment.
- Provide env-specific login URLs/emails.
- Depend on core Field/Options/System.
- Provide its own permissions.
- Serve administration/deployment.
- MANAGE sensitive values (login URLs, email addresses).
- Restrict the tracking permission to trusted admins.
- Avoid cross-pointing prod/non-prod endpoints + keep secrets out of config.
- Have no access-control role beyond permission.
- Configure the tracked fields + env values.
- Handle env-value tracking.
- Track values.
- Configure the tracker.
- Swap values.
- Handle the environments.
- Manage values.
- Set env values.
- Restrict the permission.
- Provide field-value tracking.
