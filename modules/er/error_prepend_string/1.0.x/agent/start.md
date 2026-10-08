<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Error prepend string (error_prepend_string) — agent index

**Wraps response content with PHP's `error_prepend_string` / `error_append_string` ini values via one kernel RESPONSE event subscriber.** Package `UI`. No dependencies. Core `^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1 (dir 1.0.x).

- **The event subscriber, the ini values it reads, how it wraps content, the shipped guard bug, and how to set the strings** → [api/response-subscriber.md](api/response-subscriber.md)

## What it actually is

- One service, `error_prepend_string.event_subscriber` (`error_prepend_string.services.yml`), tagged `event_subscriber`, class `ErrorPrependStringEventSubscriber` in `src/EventSubscriber/ErrorPrependStringEventSubscriber.php`.
- No routes, no permissions, no config object, no config schema, no plugins, no Drush, no hooks, no `composer.json`, no submodules. Only 4 files ship (info.yml, services.yml, the subscriber, LICENSE).
- Wrapper strings come only from PHP ini (server config), set via `php.ini` / `.htaccess` / `settings.php` `ini_set()` — there is no admin UI.

## Mechanism (from source)

- `getSubscribedEvents()` subscribes `KernelEvents::RESPONSE => 'onResponse'`.
- `onResponse()` reads `$prefix = ini_get('error_prepend_string')` and `$suffix = ini_get('error_append_string')` and would set the response content to `$prefix . $content . $suffix`.
- **Shipped guard bug:** the block is gated by `!$event->getResponse()->getStatusCode() == 500`. PHP precedence makes this `(!$statusCode) == 500`, which is `false` for every real HTTP status (200/404/500/301), so as shipped in 1.0.1 the block never executes and no wrapping occurs. Correcting the condition (e.g. `$statusCode != 500`) is required for it to run.
- When it does run, wrapping only reaches responses from thrown exceptions; fatal errors go through core's error handler and need a separate core patch.
