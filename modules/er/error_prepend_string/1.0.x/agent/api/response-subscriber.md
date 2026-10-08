<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Response event subscriber

The whole module is one event subscriber. There is no config, route, permission, form, or schema.

## Install / enable

```bash
composer require drupal/error_prepend_string   # no composer.json ships; installs by project name
drush en error_prepend_string -y
```

No configuration step in Drupal. The wrapper text is read from PHP ini at request time, so you set it in the server's PHP config, not in Drupal.

## Service

`error_prepend_string.services.yml`:

- Service id `error_prepend_string.event_subscriber`
- Class `Drupal\error_prepend_string\EventSubscriber\ErrorPrependStringEventSubscriber`
- No constructor arguments
- Tag `event_subscriber`

## Class: `ErrorPrependStringEventSubscriber`

`src/EventSubscriber/ErrorPrependStringEventSubscriber.php` — implements `EventSubscriberInterface`.

- `getSubscribedEvents()` returns `[KernelEvents::RESPONSE => 'onResponse']`.
- `onResponse($event)`:
  - `$prefix = ini_get('error_prepend_string')`
  - `$suffix = ini_get('error_append_string')`
  - `$content = $event->getResponse()->getContent()`
  - `$event->getResponse()->setContent($prefix . $content . $suffix)`

Only the two PHP ini directives feed the prefix/suffix; nothing request-derived is involved.

## Setting the ini values

Set them wherever the server reads PHP config, e.g. `php.ini`:

```ini
error_prepend_string = "<style>@media (prefers-color-scheme: dark){*{background:black;color:#ff6b6b;font-family:monospace}}</style>"
error_append_string  = "<!-- appended -->"
```

Alternatives: `.htaccess` (`php_value error_prepend_string "..."`) or a `settings.php` `ini_set('error_prepend_string', '...')` call. Under DDEV, add a PHP config file in `.ddev/php/`.

## Shipped guard bug (behaviour caveat)

The `setContent()` call is wrapped in:

```php
if (!$event->getResponse()->getStatusCode() == 500) { ... }
```

PHP evaluates `!` before `==`, so this is `(!$statusCode) == 500`. For any real HTTP status (200, 404, 500, 301, ...) `!$statusCode` is `false`, and `false == 500` is `false`. The block therefore never runs in release 1.0.1, and the subscriber does not wrap any response. To make it work as intended the condition must be rewritten (for example `$statusCode != 500`, or dropped entirely to wrap all responses). Confirm the corrected scope suits your needs — when active it appends to every matching response body, including non-HTML ones.

## Scope limits

- Even when the guard is fixed, this reaches responses produced from thrown exceptions. Fatal errors are handled by Drupal core's error handler; covering those needs a core patch (project issue #3518839 provides Drupal 10.x/11.x patches applied via `cweagans/composer-patches`).
- No caching, no access logic, no user input — the subscriber only reads server-set ini and rewrites the outgoing body.
