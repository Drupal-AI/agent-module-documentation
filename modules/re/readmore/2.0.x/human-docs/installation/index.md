# Installation

## Requirements

Readmore is lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which is enabled on any standard Drupal
  site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/readmore -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/readmore -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en readmore -y
```

That's all the setup Readmore needs. There is no configuration form to visit —
the new **Readmore** formatter is now available on the *Manage display* tab of
any entity that has a `text`, `text_long`, or `text_with_summary` field. See the
[overview](../index.md#how-to-use-it) for how to select and tune it.
