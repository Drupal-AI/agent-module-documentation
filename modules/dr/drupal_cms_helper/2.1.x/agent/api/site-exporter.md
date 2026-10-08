<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Programmatic API

## `SiteExporter` service — `@api`

Class `Drupal\drupal_cms_helper\SiteExporter` (autowired; inject by class name). This is the
engine behind `drush site:export`; call it from custom code to build a recipe.

```php
$exporter = \Drupal::service(\Drupal\drupal_cms_helper\SiteExporter::class);
$exporter->export($destination, $base = NULL, $dev = FALSE);
```

Public methods (`@api`):
- `export(string $destination, ?string $base = NULL, bool $dev = FALSE): void` — writes a
  full `Site`-type recipe (`recipe.yml`, `composer.json`, `config/`, `content/`) to
  `$destination`. `$base` is an optional base-recipe path to copy first; `$dev = TRUE` enables
  theme development mode instead of forcing asset aggregation. Throws `\RuntimeException` if
  any `canvas.*` config has content dependencies.
- `getExtensionRequirements(array $extensions): array` — given `Extension[]`, returns Composer
  version constraints keyed by package name (e.g. `['drupal/token' => '^1.17']`), falling back
  to `*` with a warning when a version can't be resolved.
- `getRecipePath(?string $name = NULL): ?string` — returns the path where Composer installs a
  recipe (the "cookbook" dir), or the resolved path for a specific recipe package `$name`, or
  `NULL` if none is configured.

## Site-export route — `@api`

`drupal_cms_helper.site_export` → `GET /admin/config/development/site-export`
(permission: `administer site configuration`). Streams the whole site exported as a `.zip`
recipe (built via `SiteExporter::export()` on top of the `drupal_cms_site_template_base`
base recipe if present). The controller itself is `@internal`; the route path is `@api`.

## Not for external use

`ContentLoader`, `GenericConfigurationListener`, `ProcessRunner`, `FilteringMessenger`,
the `EventSubscriber\*` classes, `BrandingBlock` and the `Hook\*` classes are all `@internal`
and may change or be removed without warning — don't call them from other code.
