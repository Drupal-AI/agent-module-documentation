<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `decoupled_kit` path-resolution service

`Drupal\decoupled_kit\DecoupledKit` (interface `DecoupledKitInterface`), service id `decoupled_kit`.
Arguments: `@entity_type.manager`, `@language_manager`, `@path.validator`, `@router.route_provider`
(`decoupled_kit.services.yml`). It is the shared helper used by the Router resource and by both
submodules' resources; it does no HTTP work of its own.

## Install & enable

```bash
composer require drupal/decoupled_kit   # pulls jsonapi_resources
drush en decoupled_kit -y
```

## Methods (all in `DecoupledKit.php`)

- `canonicalPath($path, $url_path_only = TRUE): string` — lowercases + trims, optionally reduces to
  the URL path component with `parse_url(..., PHP_URL_PATH)`, and returns a single leading-slash path
  (`sprintf('/%s', ltrim($path, '/'))`). Normalizes a front-end URL into a Drupal-style path.
- `checkPath(Request $request, $needCanonicalUrl = TRUE): string` — reads the `current_path`
  **query** parameter; throws `NotFoundHttpException` if empty (this is how the resources 404 on a
  missing path); returns `canonicalPath()` output unless `$needCanonicalUrl` is FALSE (the redirect
  resource passes FALSE to keep the raw path for alias lookup).
- `getEntityFromPath($path, $checkAllow = TRUE)` — resolves the path with
  `Url::fromUri("internal:".$path)->getRouteParameters()`, takes the first route parameter as the
  entity type (`view_id` is mapped to `view`), loads it via `entityTypeManager`. For views it can
  drill into `getDisplay($display_id)`. If the loaded entity is `TranslatableInterface` and has a
  translation for the current language, returns that translation. Returns `NULL` on any failure.
  Note: `$checkAllow` is accepted but not used to gate loading — access is enforced later by
  JSON:API normalization, not here.
- `getRouteMatchFromPath($path)` — validates the path with `path.validator` (`getUrlIfValid`),
  looks up the route via `router.route_provider`, and returns a `RouteMatch`, else `NULL`. Used by
  the block resource to build a breadcrumb for a path.

## Notes

- The service resolves entities from **internal** paths; callers pass canonicalized paths.
- No caching is done in the service; each resource adds its own cacheability
  (`url.query_args:current_page`).
