<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `modules_weight` service

Service id **`modules_weight`** — class `Drupal\modules_weight\ModulesWeight`
(implements `ModulesWeightInterface`), constructed with `@config.factory` and
`@extension.list.module`.

## `getModulesList(bool $show_core_modules): array`

Returns the installed, compatible modules with their metadata, keyed by machine name — used by
both the reorder form and the `mw-list` Drush command. Each entry carries at least `name`,
`weight`, and `package`. Pass `TRUE` to include Core (`package: Core`) modules, `FALSE` to
exclude them (mirroring the `show_system_modules` setting).

```php
$list = \Drupal::service('modules_weight')->getModulesList(FALSE);
// e.g. $list['pathauto']['weight']
```

## Applying a weight

The module does not define a custom write API — setting a weight goes through core's
`module_set_weight($module, $weight)`, which updates `core.extension` → `module.<name>`. Read
a current weight straight from config:

```php
$weight = \Drupal::config('core.extension')->get('module')['pathauto'] ?? 0;
```

There are no plugin types, hooks-for-you, or events; this service plus `module_set_weight()`
are the whole programmatic surface.
