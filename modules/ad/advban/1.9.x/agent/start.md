<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Ban (advban) — agent index

IP banning with ranges, expiry dates, reasons and a protected (allow-list) — a superset of
core's Ban module. State lives in the **`advban_ip` DB table**, settings in
**`advban.settings`**. No plugin types, no Drush commands, no entities.

- **Settings keys, admin routes, protected IPs, expiry durations** →
  [configure/settings.md](configure/settings.md)
- **`advban.ip_manager` service — ban/unban/check from code, the middleware, cron** →
  [api/ip-manager.md](api/ip-manager.md)
- **The single permission and what it gates** →
  [permissions/advban.md](permissions/advban.md)

Key facts:

- Configure route: `advban.admin_page` → `/admin/config/people/advban` (settings tab is
  `/admin/config/people/advban/settings`).
- Table `advban_ip`: `iid, ip, ip_end, expiry_date (int, 0 = never), reason`.
  Single ban ⇒ `ip` is the literal string and `ip_end` is `''`.
  Range ban ⇒ `ip` and `ip_end` are `ip2long()` **integers** (IPv4 only).
- `advban.settings` has **no `config/install` default file** — the config object does not
  exist until the settings form is saved or `expiryDurations()` lazily writes it.
- Protected IPs always beat bans; the middleware checks `isProtected()` first.
