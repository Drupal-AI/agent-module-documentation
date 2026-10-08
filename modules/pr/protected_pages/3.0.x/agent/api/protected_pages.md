# Programmatic API — storage service & how protection works

There is **no config entity and no plugin type**. Protected pages are rows in the
`protected_pages` database table, managed by one service.

## Storage service — `protected_pages.storage`

`Drupal\protected_pages\ProtectedPagesStorage` (constructor arg: `@database`).

```php
/** @var \Drupal\protected_pages\ProtectedPagesStorage $storage */
$storage = \Drupal::service('protected_pages.storage');

// Add a protected page. Password MUST be pre-hashed with the core 'password' service.
$pid = $storage->insertProtectedPage([
  'password' => \Drupal::service('password')->hash('secret'),
  'title'    => 'Events area',
  'path'     => '/new-events/*',   // must start with '/', '*' wildcards allowed
]);

$storage->updateProtectedPage(['path' => '/new-events'], $pid);
$storage->deleteProtectedPage($pid);

// Fetch. $fields limits columns; $conditions uses 'or'/'and'/'general' groups of
// ['field','value','operator']; $get_single_field=TRUE returns one scalar.
$all  = $storage->loadAllProtectedPages();                 // ALL rows, pid DESC, no pager
$page = $storage->listAllProtectedPages();                 // paginated, 20/page, pid DESC
$pid  = $storage->loadProtectedPage(
  ['pid'],
  ['general' => [['field' => 'path', 'value' => '/new-events', 'operator' => '=']]],
  TRUE
);
```

`loadAllProtectedPages()` returns **every** row (used by the subscriber so all wildcard rules
are matched); `listAllProtectedPages()` is the pager-extended, 20-per-page variant used by the
admin list controller.

Table `protected_pages` (from `hook_schema`): `pid` (serial PK), `password` varchar(128,
hashed), `path` varchar(255, indexed), `title` varchar(255, nullable).

## How a page gets protected (no code needed to invoke)

`Drupal\protected_pages\EventSubscriber\ProtectedPagesSubscriber` (service
`protected_pages.check_protected_page`) subscribes to `KernelEvents::RESPONSE` and on every
response (`checkProtectedPage()`):

1. Returns immediately if the user has `bypass pages password protection`.
2. Resolves the current path + alias, then matches it against every stored path using the core
   `path.matcher` (so `*` wildcards work; the `/protected-page` login path is excluded), falling
   back to an exact path/alias DB lookup; if no match, also checks the request's `node` route
   param as `/node/{nid}`.
3. If a matching `pid` is found and the session has no valid (unexpired) unlock for it,
   `sendAccessDenied()` triggers the page-cache kill switch and sends a `RedirectResponse` to
   `internal:/protected-page?destination=…&protected_page={pid}`. The event response is also set
   to `204 No Content`.

## The password prompt — `protected-page`

`Drupal\protected_pages\Form\ProtectedPagesLoginForm` (form id `protected_pages_enter_password`)
checks the submitted password against the per-page password and/or the global password per the
`password.per_page_or_global` mode, using `\Drupal\Core\Password\PasswordInterface::check()`.
Access (`accessProtectedPageLoginScreen`) requires a numeric `protected_page` query param **and**
either the `access protected page password screen` permission or uid 1. On success it writes
`$_SESSION['_protected_page']['passwords'][$pid]` (request time + optional expiry) — the unlock
the subscriber looks for — and clears the IP flood counter.

## Related services

- `password` (core) — hash/check passwords; always hash before storing.
- `path.matcher` (core) — wildcard path matching used by the subscriber.
- `path_alias.manager` (core) — resolves alias ↔ internal path both ways.
- `flood` (core) — IP throttling of wrong password attempts.
- `page_cache_kill_switch` (core) — prevents caching the protected redirect.
