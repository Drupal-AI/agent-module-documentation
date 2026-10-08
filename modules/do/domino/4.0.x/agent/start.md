<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Domino (domino) — agent index

An **opinionated, developer-focused module** that applies an environment-aware baseline to a Drupal
project: auto-generated test users, super-admin hardening, resilience to truncated user tables,
three Config Split definitions, two standard roles, and email/SMS testing helpers. No admin UI —
everything is driven by the `domino.settings` config object, expected to be set per environment in
`settings.php`. Package `Domino`. Core `^10.1 || ^11`. License GPL-2.0-or-later. Version 4.0.x.

- **Config object `domino.settings` (every key + defaults), the shipped install config, and how to
  configure it per environment** → [config/settings.md](config/settings.md)
- **The helper services, hooks and event subscribers that do the work (test users, super-admin,
  anonymous user, status message, mail handling)** → [services/lifecycle.md](services/lifecycle.md)

## Dependencies

- Required modules: `config_split`, `reroute_email` (from `.info.yml`).
- Composer also pulls `mailslurp/mailslurp-client-php ^15` (used only by the MailSlurp email-delivery
  test feature).
- Optional: `features` (only to receive updates of the bundled config).
- Submodule: **`domino_sms`** — documented separately under
  [`modules/domino_sms/4.0.x/`](../../modules/domino_sms/4.0.x/agent/start.md); depends on
  `domino` + `sms` (SMS Framework).

## What it actually provides (from source)

- **No** routes, controllers, forms, permissions, plugins or Drush commands. No config schema.
- **Config**: object `domino.settings` (`config/install/domino.settings.yml`); three Config Split
  entities `config_split.config_split.{development,staging,production}` (all `status: false`,
  pointing at `../config/split/<env>`); two roles `user.role.developer` (`is_admin: true`) and
  `user.role.manager`; an optional Features bundle `features.bundle.domino`.
- **Services** (`domino.services.yml`): `domino.test_users` (`TestUsers`),
  `domino.super_admin_user` (`SuperAdminUser`), `domino.anonymous_user` (`AnonymousUser`),
  `domino.status_message` (`StatusMessage`), a `logger.channel.domino`, and three
  `event_subscriber`-tagged subscribers (`TestUsersSubscriber`, `SuperAdminUserSubscriber`,
  `StatusMessageSubscriber`).
- **Hooks** (`domino.module`): `hook_cache_flush`, `hook_cron`, `hook_mail_alter`,
  `hook_module_implements_alter` (runs domino's `mail_alter` last), `hook_entity_load`; plus
  `hook_install` / `hook_update_N` in `domino.install`.
- **Environment modes** via `ApplicationInterface`: `MODE_DEVELOPMENT`, `MODE_STAGING`,
  `MODE_PRODUCTION`. Most behaviour is gated on `application_mode` (default `production`).

## Mechanics in one line

Cron (`domino_cron`) is the primary trigger and cache flush (`domino_cache_flush`) the setup
trigger; the three event subscribers run the same `regularCheck()`/`displayStatusMessage()` logic on
`KernelEvents::REQUEST` as a **fallback** (frequency-throttled via `state`), so test-user and
super-admin state self-heal even if cron stalls. See [services/lifecycle.md](services/lifecycle.md).
