# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **[scssphp](https://scssphp.github.io/scssphp/) library** (`scssphp/scssphp ^2`)
  — this is the pure-PHP engine that does the actual compiling. When you install the
  module with Composer (below), this library is pulled in automatically.
- No dependent Drupal modules.

## Install with Composer

From the project root:

```bash
composer require drupal/scss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and Composer will fetch the `scssphp/scssphp` library along
with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scss -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scss -y
```

## Verify it worked

Visit **Configuration → Development → SCSS** (`/admin/config/development/scss`). If
the settings form loads, the module is active. The module also checks that the
scssphp library is loadable before compiling, so if the library is missing it will
report an error rather than fail silently. See
[Configuration](../configuration/index.md) to point it at a theme.

## Compiling from the command line

The module registers a Drush command so you can compile without a page request —
useful in deployment scripts:

```bash
drush scss
```

Because the command hook is declared in the older Drush 8 style, confirm it
registers on your Drush version with `drush list | grep scss`.
