# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).

There are no third-party Composer libraries and no other Drupal module
dependencies. In most cases you will not install this module by hand at all — it
arrives automatically as a dependency of another module that needs variation
caching on older core.

> **Deprecated:** on Drupal 10.2 and newer this module only supplies class aliases
> to the equivalent core classes. If you are on 10.2+ and nothing references the
> `variationcache` namespace, you do not need it — use the core
> `\Drupal\Core\Cache\VariationCache` classes directly.

## Install with Composer

From the project root:

```bash
composer require drupal/variationcache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/variationcache -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en variationcache -y
```

That is all. There is no configuration form, no permissions to grant, and no
submodules — once enabled, the `variation_cache_factory` service is available to any
code that needs it.

## Removing it later

If your site is fully on Drupal 10.2+ and no custom or contrib code imports the
`\Drupal\variationcache\Cache\*` classes, you can safely uninstall the module and
switch any type-hints to the core `\Drupal\Core\Cache\*` classes:

```bash
drush pmu variationcache -y
```
