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
$all  = $storage->loadAllProtectedPages();                 // paginated, 20, pid DESC
$pid  = $storage->loadProtectedPage(
  ['pid'],
  ['general' => [['field' => 'path', 'value' => '/new-events', 'operator' => '=']]],
  TRUE
);
```

Table `protected_pages` (from `hook_schema`): `pid` (serial PK), `password` varchar(128,
hashed), `path` varchar(255, indexed), `title` varchar(255, nullable).

## How a page gets protected (no code needed to invoke)

`Drupal\protected_pages\EventSubscriber\ProtectedPagesSubscriber` (service
`protected_pages.check_protected_page`) subscribes to `KernelEvents::RESPONSE` and on every
response:

1. Returns immediately if the user has `bypass pages password protection`.
2. Resolves the current path + alias, then matches it against every stored path using the core
   `path.matcher` (so `*` wildcards work), falling back to an exact path/alias DB lookup; also
   checks the request's `node` route param as `/node/{nid}`.
3. If a matching `pid` is found and the session has no valid unlock for it, it triggers the page
   cache kill switch and redirects to `internal:/protected-page?protected_page={pid}&destination=…`.

## The password prompt — `protected-page`

`Drupal\protected_pages\Form\ProtectedPagesLoginForm` (form id `protected_pages_enter_password`)
checks the submitted password against the per-page password and/or the global password per the
`password.per_page_or_global` mode, using `\Drupal\Core\Password\PasswordInterface::check()`.
On success it writes `$_SESSION['_protected_page']['passwords'][$pid]` (request time + optional
expiry) — the unlock the subscriber looks for — and clears the IP flood counter.

## Related services

- `password` (core) — hash/check passwords; always hash before storing.
- `path.matcher` (core) — wildcard path matching used by the subscriber.
- `flood` (core) — IP throttling of wrong password attempts.
