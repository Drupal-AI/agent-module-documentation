# How Trailing Slash works (for overriding / debugging)

The module only touches **outbound** URL generation. It adds no inbound redirect — a request to
`/about` is not redirected to `/about/`; rather, when Drupal *generates* the link to `/about` it
comes out as `/about/`. Pair with a redirect strategy (web server or `redirect` module) if you
also want inbound canonicalization.

## Outbound path processor

`src/PathProcessor/TrailingSlashOutboundPathProcessor` — tagged
`path_processor_outbound` with **priority -1** so it runs after all other outbound processors
(comment: "must be executed as the last PathProcessor"). Injected with `router.admin_context`,
`entity_type.manager`, `path.matcher`.

`processOutbound()` → if `isPathWithTrailingSlash()` returns TRUE, calls
`TrailingSlashHelper::add($path)`.

`isPathWithTrailingSlash()` returns TRUE only when **all** hold:
- feature `enabled` is TRUE (`TrailingSlashSettingsHelper::isEnabled()`);
- path is not `<front>` and not empty;
- not an admin path — `isAdminPath()` is TRUE for paths starting `/admin` or `/devel`, or when
  `router.admin_context` says the route is admin;
- and **either** `isPathInListWithTrailingSlash()` (a configured `paths` pattern matches via
  `path.matcher`) **or** `isBundlePathWithTrailingSlash()` (the path resolves via
  `Url::fromUri('internal:'.$path)` to a routed entity whose `entity_type → bundle` is enabled in
  `enabled_entity_types`).

Internal `checkingPaths` / `checkedPaths` arrays memoize and guard against recursion during the
same request.

## The slash regex

`TrailingSlashHelper::add()`:
```php
$path = preg_replace('/((?:^|\/)[^\/\.]+?)$/isD', '$1/', $path);
```
Appends `/` to the final path segment **only if that segment contains no `/` and no `.`** — so
file-like URLs (`…/logo.png`) and already-slashed paths are left unchanged (idempotent).

## Multilingual front-page fix

`src/TrailingSlashServiceProvider` (`alter()`) replaces the class of the core
`url_generator.non_bubbling` service with `src/Routing/TrailingSlashUrlGenerator` (extending core
`UrlGenerator`) and injects `path_processor_language` + `language_manager`. Its
`generateFromRoute()` re-adds the trailing slash to the `<front>` URL when the site is
multilingual and a language prefix is present (core strips it after prefixing). The swap only
happens if both `url_generator.non_bubbling` and `path_processor_language` exist — hence the
hard dependency on the core **language** module.

## Extending

- Add path patterns or bundle rules through config (see
  [../configure/settings.md](../configure/settings.md)) — no code needed for normal use.
- To change matching logic, decorate/replace `TrailingSlashOutboundPathProcessor` (keep priority
  low so it runs last) or the `TrailingSlashHelper::add()` regex.
- `TrailingSlashSettingsHelper` exposes static `isEnabled()`, `getActivePaths()`,
  `getActiveBundles()`, `getContentEntityTypes()` (each statically cached per request) if you
  need to read the effective configuration from your own code.
