<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Expire — agent index

Blocks accounts automatically — **per user** on a set date, or **per role** after N seconds of
inactivity — and emails a warning first. All blocking runs on `hook_cron`. Depends on `user`.
Configure route: `user_expire.admin` (`/admin/config/people/user-expire`).

- **Settings config keys, per-role rules, warning emails, mail template, permissions** →
  [configure/settings.md](configure/settings.md)
- **How expiration works: `user_expire` table, per-user API, cron logic, Views, Rules action,
  report route** → [api/mechanics.md](api/mechanics.md)

Key facts:
- All config in `user_expire.settings`: `user_expire_roles` (role_id => inactivity seconds, 0 =
  off), `send_expiration_warnings` (bool), `frequency` (secs between warning re-sends, default
  172800 = 2d), `offset` (secs before expiry to start warning, default 604800 = 7d),
  `expiration_warning_mail` (subject/body).
- Per-user dates live in the DB table `user_expire` (`uid`, `expiration` timestamp), **not** in
  config — set via the "User expiration" section on the user edit form.
- Three restricted permissions: `set user expiration`, `view expiring users report`,
  `administer user expire settings`.
