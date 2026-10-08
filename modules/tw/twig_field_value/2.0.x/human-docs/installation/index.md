# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No module dependencies and no external PHP libraries — Twig Field Value is entirely self‑contained.

The module ships no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_field_value -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/twig_field_value -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_field_value -y
```

There is nothing to configure — the module registers its four Twig filters (via a `twig.extension` service) as soon as it is enabled, and they become available in every template.

**Verify it worked.** Add a filter to any theme template — for example `{{ content.field_foo|field_label }}` in a node template — rebuild the cache (`drush cr`), and reload the page. If the field's label prints on its own with no field wrappers, the filters are working. See the [How to use it](../index.md#how-to-use-it) section for the full set of filters and examples.
