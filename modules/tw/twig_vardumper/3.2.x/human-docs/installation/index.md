# Installation

## Requirements

Twig VarDumper needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **`symfony/var-dumper`** library (`^5 | ^6 | ^7`) — this does the actual
  rendering. Drupal core already ships it, so you normally have it already; the
  module checks for it at install time via `hook_requirements`.
- No other modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/twig_vardumper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in
`symfony/var-dumper` (if not already present) and update any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/twig_vardumper -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en twig_vardumper -y
```

## Turn on Twig debug

This is essential: the `dump()` / `vardumper()` functions render **only** when
Twig debug is enabled. Set it in a development services file and rebuild caches —
see [How to use it](../index.md#how-to-use-it) in the overview for the exact
YAML. With debug off, the functions output nothing (which is by design, and safe
for production).
