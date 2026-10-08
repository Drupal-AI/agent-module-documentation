<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DDoS Security (ddos_security) — agent index

Application-layer **per-IP request-rate limiter** for **anonymous** traffic. A `KernelEvents::REQUEST`
subscriber counts each client IP's hits-per-minute in its own `ddos_security` DB table and, past a
configurable threshold, marks the IP `blocked` and redirects it to an internal alert page. Package
`Security`. Depends only on core **`user`**. Core requirement `^8 || ^9 || ^10 || ^11`. License
GPL-2.0-or-later. Version 2.0.0. **Not** a network/edge DDoS defence — it is a PHP-level throttle, so
only sub-PHP-saturating floods and only anonymous requests are affected.

- **Settings, config object/schema, routes, permissions, admin UI, CSV/mail reporting** →
  [config/settings.md](config/settings.md)
- **Runtime mechanism: the event subscriber, DB schema, counting/blocking logic, crypt service, hooks** →
  [internals/protection.md](internals/protection.md)

## What it actually is

- **One event subscriber**: `AttackProtection` (`src/EventSubscriber/AttackProtection.php`), service
  `ddos_security.attack_protection`, tagged `event_subscriber`, method `ddosSecurity` on
  `KernelEvents::REQUEST` priority **300**. All throttling happens here.
- **One config object**: `ddos_security.settings` (schema in `config/schema/ddos_security.schema.yml`
  covers only `message`/`403_message`; the rest of the keys live in `config/install`). Config
  translation enabled.
- **One DB table**: `ddos_security` (`ddos_security.install` `hook_schema`) — columns `sid` (serial PK),
  `sno` (per-minute timestamp serial), `ip_address`, `status` (`allowed`/`blocked`), `created_date`.
- **Controllers**: `DdosSecurityPage::displayAlertMessage` (the `/ddos-alert-message` page),
  `DdosSecurityEntryList::entryList` (paged admin IP table + search),
  `DdosSecurityCSVReport::build` (CSV export).
- **Forms**: `DdosSecurityConfigSettingsForm` (settings), `DdosSecurityEntrySearch` (search box),
  `DdosSecurityEntryDeleteForm` (`ConfirmFormBase` for block/unblock/delete an IP).
- **Service** `ddos_security.crypt` → `Services\DdosCrypt` (AES-256-CBC helper used to obfuscate the
  IP/action/keyword values placed in admin action URLs).
- **Hooks** (`ddos_security.module`): `hook_theme` (`ddos_alert_message`), `hook_cron` (daily mail log),
  `hook_mail`, `hook_preprocess_page` (strips page regions on the alert page), plus the helper
  `ddos_security_user_access_status()`.
- **No** custom permissions (every admin route uses core `administer site configuration`), **no** Drush,
  **no** plugin types, **no** submodules, **no** third-party libraries.

## Provided routes (all admin routes = `administer site configuration`)

- `ddos_security.settings` — `/admin/config/ddos-security-config/settings` (settings form)
- `ddos_security.ddos_security_entry_search` — `/admin/config/ddos-security-entry/{search_keyword}` (IP list)
- `ddos_security.ddos_security_entry_delete` — `/admin/config/ddos-security-action/{action}/{ip}` (confirm form)
- `ddos_security.csv_export` — `/admin/config/ddos-security/export/csv` (CSV download)
- `ddos_security.admin_config` — `/admin/config/ddos-security` (menu block landing)
- `ddos_security.displaypage` — `/ddos-alert-message` (`access content`; the public blocked/alert page)

The configure route is `ddos_security.settings`.
