<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Challenge Mitigation (challenge_mitigation) — agent index

Application-layer anti-abuse for Drupal 10/11. A `KernelEvents::REQUEST` subscriber serves a
one-time challenge page to anonymous visitors on configured paths; passing whitelists the
client IP (a `cm_whitelist_ip` content entity) for a configurable duration, and `hook_cron()`
purges expired entries. Not a WAF replacement (maintainer's own note).

- **Package:** Security. **Core:** `^10 | ^11`. **Version dir:** 1.0.x (installed 1.0.0).
- **Dependencies:** none required. Optional runtime integration with contrib `captcha`
  (checked via `moduleHandler->moduleExists('captcha')`, used only in `hard` mode).
- **License:** GPL-2.0-or-later.

## What it provides
- **Content entity** `cm_whitelist_ip` (`src/Entity/ChallengeMitigationWhitelistIp.php`) —
  base fields `ip`, `origin`, `created`; base_table `cm_whitelist_ip`; delete form +
  list builder handlers.
- **Service** `challenge_mitigation.challenge_subscriber`
  (`src/EventSubscriber/ChallengeMitigationSubscriber.php`) — the request-time enforcer,
  priority 100.
- **Forms:** `ChallengeMitigationSettingsForm` (config), `ChallengeMitigationAccessForm`
  (public challenge form, id `challenge_mitigation_access_form`),
  `ChallengeMitigationIpFilterForm` (whitelist filter).
- **Config object** `challenge_mitigation.settings` (+ schema).
- **Permission** `administer challenge mitigation whitelist` (gates every route).
- **Library** `challenge_mitigation/challenge_js` (`js/challenge.js`, auto-submits the JS
  challenge; deps core/drupal, core/once).
- **Templates** `challenge-mitigation-page` / `challenge-mitigation-form` (hook_theme).

## Routes (all `_permission: administer challenge mitigation whitelist`)
- `challenge_mitigation.settings` — `/admin/config/challenge-mitigation/settings` (settings form).
- `entity.cm_whitelist_ip.collection` — `/admin/config/challenge-mitigation/whitelist_ips`.
- `entity.cm_whitelist_ip.delete_form` — `.../whitelist_ips/{cm_whitelist_ip}/delete`.
- `challenge_mitigation.admin` — `/admin/config/challenge-mitigation` (menu block).

## Solution docs
- [Configuration & settings](config/settings.md) — every `challenge_mitigation.settings` key,
  challenge modes, allow-lists, cookie bypass.
- [Request enforcement flow](api/enforcement.md) — how the subscriber decides to challenge,
  what passing does, cron cleanup.
- [Whitelist IP entity & admin list](entity/whitelist_ip.md) — entity fields, list builder,
  filtering, delete.
