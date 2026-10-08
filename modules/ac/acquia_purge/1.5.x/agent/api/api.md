# Programmatic API & extension points

Acquia Purge is a set of **Purge plugins** (it does not define its own plugin type — it
implements Purge's `@PurgePurger`, `@PurgeTagsHeader` and `@PurgeDiagnosticCheck` types).
You normally never call it directly; Purge's queue/processors invoke the purgers. Use the API
below to read platform facts or to add a Platform CDN backend.

## Platform detection — `acquia_purge.platforminfo`

`Drupal\acquia_purge\AcquiaCloud\PlatformInfo` (interface `PlatformInfoInterface`), constructed
from `%site.path%`, `@settings`, `@state`.

```php
/** @var \Drupal\acquia_purge\AcquiaCloud\PlatformInfoInterface $info */
$info = \Drupal::service('acquia_purge.platforminfo');

$info->isThisAcquiaCloud();        // bool — is this really Acquia Cloud?
$info->getBalancerAddresses();     // string[] load-balancer IPs (from 'reverse_proxies')
$info->getBalancerToken();         // X-Acquia-Purge auth token (site name or acquia_purge_token)
$info->getSiteIdentifier();        // unique per-site hash used to scope 'everything' purges
$info->getSiteName();              // e.g. sitegroup.env
$info->getSiteGroup();
$info->getSiteEnvironment();
$info->getSitePath();
$info->getPlatformCdnConfiguration(); // array; throws RuntimeException if none
```

## Purger plugins (implement Purge's `PurgerInterface`)

- `acquia_purge` — `AcquiaCloudPurger` (label "Acquia Cloud"). Types: `url`, `wildcardurl`,
  `tag`, `everything`. Sends concurrent (max 6) `PURGE`/`BAN` requests to balancer IPs; tags are
  grouped 15/request and hashed. `everything` sends `BAN http://<ip>/site` scoped by site id.
- `acquia_platform_cdn` — `AcquiaPlatformCdnPurger` (label "Acquia Platform CDN"). Types: `url`,
  `tag`, `everything`. Delegates to a backend from `AcquiaPlatformCdn\BackendFactory`.

## Extend: add an Acquia Platform CDN backend

Backends live under `Drupal\acquia_purge\AcquiaPlatformCdn`:
`BackendInterface`, abstract `BackendBase`, and the built-in `FastlyBackend`.
`BackendFactory::get(PlatformInfoInterface, ClientInterface, LoggerInterface)` selects a backend
by the `vendor` key in the Platform CDN configuration. Add a class named `<Vendor>Backend` in that
namespace (extending `BackendBase`) to support another CDN vendor.

## TagsHeader plugins (Purge `@PurgeTagsHeader`)

`acquiapurgecloudtagsheader` (`X-Acquia-Purge-Tags`), `acquiapurgecloudsiteheader`,
`acquiapurgecdntagsheader` — set on cacheable responses by
`EventSubscriber\CacheableResponseSubscriber` (overrides Purge's, priority -1000).

## Services (`acquia_purge.services.yml`)

- `acquia_purge.platforminfo` (public) — the object above.
- `acquia_purge.tagsheaders.cacheable_response_subscriber` — response subscriber for tag headers.
- `http_client_middleware.acquia_purge_balancer_middleware` — inspects balancer responses,
  throws `AcquiaCloudBalancerException` on failure.
- `http_client_middleware.acquia_purge_debugger_middleware` — active under Purge debug mode.
