# Raven (Sentry Integration) — agent guide

Raven forwards Drupal errors, log messages, exceptions and performance traces to
Sentry. All settings live in one config object, `raven.settings`, exposed on the
core Logging and errors form (`system.logging_settings`,
`/admin/config/development/logging`) — Raven adds no admin page of its own.

- **Configure it** (settings keys, DSN, env vars, tracing, logs) → [configure/raven.md](configure/raven.md)
- **Drush commands** (`raven:captureMessage`, `raven:captureLog`) → [drush/raven.md](drush/raven.md)
- **Programmatic API & events** (logger service, `OptionsAlter`, `AttributesAlter`, Sentry callbacks) → [api/raven.md](api/raven.md)
- **Permissions** (JavaScript errors, performance traces) → [permissions/raven.md](permissions/raven.md)
