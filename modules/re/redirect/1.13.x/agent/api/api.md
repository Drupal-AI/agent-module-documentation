# Programmatic API — services & entity

## Look up redirects — `redirect.repository`

`Drupal\redirect\RedirectRepository` (also autowirable by class name).

```php
/** @var \Drupal\redirect\RedirectRepository $repo */
$repo = \Drupal::service('redirect.repository');

// The main lookup used by the request subscriber (returns Redirect|NULL):
$redirect = $repo->findMatchingRedirect('old/path', ['ref' => '1'], 'en');

$redirect = $repo->findBySourcePath('old/path');            // array of matches
$matches  = $repo->findByDestinationUri(['internal:/node/1']);
$one      = $repo->load($redirect_id);
$all      = $repo->loadMultiple($ids);                       // NULL = all
```

## Create a redirect in code — `Redirect` entity

```php
use Drupal\redirect\Entity\Redirect;

$redirect = Redirect::create();
$redirect->setSource('old/path', ['page' => '2']);           // source path + query
$redirect->setRedirect('node/1');                            // destination (uri/route/path)
$redirect->setStatusCode(301);
$redirect->setLanguage('en');
$redirect->save();
```

Useful entity methods: `getSource()`, `getSourceUrl()`, `getSourcePathWithQuery()`,
`getRedirect()`, `getRedirectUrl()`, `getRedirectOptions()`, `getStatusCode()`,
`getHash()`, and static `Redirect::generateHash($path, $query, $langcode)` (the hash used to
find/deduplicate redirects — enforced unique by the `UniqueHash` constraint).

## Other services

- `redirect.checker` (`RedirectChecker`) — decides whether the current request may be
  redirected (access, admin path, route). `backend_overridable`.
- `redirect.prefix_list` (`RedirectPrefixList`) — cached list of path prefixes that have
  redirects, to short-circuit lookups.
- `redirect.repository` is tagged `backend_overridable` for custom storage.

The `RedirectRequestSubscriber` calls `findMatchingRedirect()` on every request and issues a
`TrustedRedirectResponse`; you normally don't invoke redirection yourself.
