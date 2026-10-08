# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- No other modules are required — Scanner has no dependencies. (It ships plugins
  for Node, Paragraph, and Commerce Product/Variation; the Commerce plugins only
  do anything if Commerce is present.)

There are no PHP library or third-party Composer requirements.

> **Pre-stable release.** The only tagged release on the `2.0.x` branch is
> **2.0.0-beta3** (beta). Test carefully before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/scanner -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/scanner -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scanner -y
```

## After enabling

Out of the box no fields are scannable and no roles have access. Before the tool
does anything you must choose scannable fields and grant permissions — see
[Configuration](../configuration/index.md).
