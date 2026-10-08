<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Raven (Sentry Integration) — agent index

Raven forwards Drupal errors, log messages, exceptions and performance traces to
Sentry (via the `sentry/sentry` PHP SDK `^4.31` and the bundled `@sentry/browser`
JS SDK). All settings live in one config object, `raven.settings`, exposed on the
core Logging and errors form (`system.logging_settings`,
`/admin/config/development/logging`) — Raven adds no admin page of its own. No
Drupal module dependencies.

Provides: the `logger.raven` Sentry-backed logger; the `OptionsAlter` /
`AttributesAlter` events; a `raven` CSP reporting-handler plugin (label "Sentry");
Drush commands; two permissions; routes `raven.tunnel` (`/raven/tunnel`),
`raven.test`, `raven.test.logs`; and event subscribers for request, config, CSP
and console (`dr` command) tracing.

- **Configure it** (settings keys, DSN, env vars, tracing, logs) → [configure/raven.md](configure/raven.md)
- **Drush commands** (`raven:captureMessage`, `raven:captureLog`) → [drush/raven.md](drush/raven.md)
- **Programmatic API & events** (logger service, `OptionsAlter`, `AttributesAlter`, Sentry callbacks) → [api/raven.md](api/raven.md)
- **Permissions** (JavaScript errors, performance traces) → [permissions/raven.md](permissions/raven.md)
