<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Masquerade Log — how it works

Masquerade Log has no configuration; it works by service decoration set up at container-compile
time. Two classes:

## `MasqueradeLogServiceProvider` (`src/MasqueradeLogServiceProvider.php`)

A `ServiceModifierInterface`. In `alter(ContainerBuilder $container)` it finds every service
tagged `logger` (`findTaggedServiceIds('logger')`), removes the `logger` tag from the original,
and registers a decorator service `"{service_id}.decorator"` (class `MasqueradeLogLogger`,
re-tagged `logger`, decorating the original) with arguments
`[<inner logger>, @session, @entity_type.manager]`. So every logger backend (e.g. `logger.dblog`,
`logger.syslog`) is wrapped.

## `MasqueradeLogLogger` (`src/MasqueradeLogLogger.php`)

A PSR `LoggerInterface` (uses `LoggerTrait`) wrapping the inner logger. In `log($level, $message,
$context)`:

1. Reads `\Drupal::…session->getMetadataBag()`; if it exposes `getMasquerade()` and returns a
   non-empty original uid (i.e. the current user is masquerading):
   - loads the original user account,
   - appends to the message:
     `' <p>[masquerading <a href="/user/@original_uid">@original_username</a>, uid @original_uid]</p>'`,
   - adds context `@original_uid` and `@original_username`.
2. Delegates to the inner logger's `log()`.

Unknown method calls are forwarded to the inner service via `__call()`.

## Verifying it is active (live introspection)

```php
get_class(\Drupal::service('logger.dblog'));   // Drupal\masquerade_log\MasqueradeLogLogger
get_class(\Drupal::service('logger.syslog'));  // same, if syslog is enabled
```

If those return the decorator class, Masquerade Log is wired into the logging pipeline.

## Notes / caveats

- The transformation only happens **when a real masquerade session is active**; it depends on
  the session/`masquerade` metadata bag, so it is exercised in a normal web request during
  masquerading, not readily from the CLI (a bare `drush` process has no masquerade session).
- Some logger services are intentionally left undecorated when another consumer needs their
  concrete type (e.g. a Sentry/Raven logger type-hinted as `RavenInterface`, or the Drush
  console logger which must implement `LoggerAwareInterface`); decorating those would break the
  container. Core `logger.dblog`/`logger.syslog` are decorated as normal.
