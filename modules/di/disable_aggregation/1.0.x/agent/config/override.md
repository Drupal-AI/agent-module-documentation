<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config override: disabling aggregation for authenticated users

## Install / enable
```
composer require drupal/disable_aggregation   # require is empty; drupal.org packaging only
drush en disable_aggregation -y
```
No dependencies (Composer or Drupal module). There is nothing to configure — enabling the
module activates the override. To revert, `drush pmu disable_aggregation -y`; no stored config
remains.

## Mechanism
Class `Drupal\disable_aggregation\DisableAggregationConfigOverrides`
(`src/DisableAggregationConfigOverrides.php`) implements
`ConfigFactoryOverrideInterface` and is registered in `disable_aggregation.services.yml`:

```yaml
services:
  disable_aggregation.config_overrider:
    class: Drupal\disable_aggregation\DisableAggregationConfigOverrides
    tags:
      - { name: config.factory.override, priority: 5 }
```

Config factory overrides let a service rewrite configuration values as they are read, without
persisting anything to storage. This one targets `system.performance`.

### `loadOverrides($names)`
```php
if (in_array('system.performance', $names)) {
  if (\Drupal::currentUser()->isAuthenticated()) {
    $overrides['system.performance'] = [
      'css' => ['preprocess' => FALSE],
      'js'  => ['preprocess' => FALSE],
    ];
  }
}
```
For any read of `system.performance` by an authenticated user, `css.preprocess` and
`js.preprocess` are forced to `FALSE`. Those two flags are exactly the "Aggregate CSS files"
and "Aggregate JavaScript files" checkboxes on `admin/config/development/performance`. With
them false, Drupal serves individual, un-minified asset files instead of combined aggregates.
Anonymous users hit neither branch (they are not authenticated), so they receive whatever the
stored `system.performance` says (normally aggregation ON).

### `getCacheableMetadata($name)`
Adds cache context `user.roles:authenticated`. This splits the render/page cache between the
authenticated and anonymous variants so anonymous visitors keep the aggregated version and
only logged-in users get the unaggregated one. Without this context the override could leak the
wrong variant across the cache.

### Other interface methods
- `getCacheSuffix()` → `'DisableAggregationConfigOverrider'` (namespaces the override's cache).
- `createConfigObject($name, $collection)` → `NULL` (the module never creates new config objects,
  only overrides an existing one).

## Priority note
The service tag uses `priority: 5`. Config overrides run in priority order; a higher-priority
override of `system.performance` (or `settings.php` `$config['system.performance']` overrides,
which always win) can supersede this one. If aggregation appears not to toggle, check for other
`config.factory.override` services or settings.php overrides of `system.performance`.

## Verifying
Log in, load a page, and view source or dev-tools network: CSS/JS should appear as many
individual files rather than a couple of hashed aggregate bundles. Log out (or use a private
window) and the same page should serve aggregated bundles again.

## Scope / limits
- Only affects the two `preprocess` flags; it does not touch caching, gzip, or other performance
  settings.
- No admin UI, no per-role granularity (any authenticated user, all roles). Per-role control is
  an open feature request upstream.
