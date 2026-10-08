# Installation

## Requirements

Format Bytes is a single Twig extension with no moving parts. It needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Nothing else — there are no third‑party Composer packages, PHP libraries, or
  other module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/format_bytes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/format_bytes -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en format_bytes -y
```

That's all it takes. There is no configuration page and no required setup. The
`format_bytes` Twig filter is available in every template as soon as the module is
enabled — see the [overview](../index.md#how-to-use-it) for usage examples.
