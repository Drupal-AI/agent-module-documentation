# Installation

## Requirements

Pager metadata is deliberately minimal. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no third‑party Composer packages, PHP library requirements, or module
dependencies beyond core. It works alongside **Views Infinite Scroll** if you use it,
but does not require it.

## Install with Composer

From the project root:

```bash
composer require drupal/pager_metadata -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pager_metadata -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pager_metadata -y
```

That's the entire setup. There is no configuration form. On install the module sets its
own module weight to `1` so its hooks run after other modules', ensuring the head links
it adds aren't overwritten. Paginated pages start getting pager‑aware canonicals and
`rel="prev"` / `rel="next"` links immediately.

The only optional tweak — a `settings.php` flag to disable the canonical rewriting — is
described in the [overview](../index.md).
