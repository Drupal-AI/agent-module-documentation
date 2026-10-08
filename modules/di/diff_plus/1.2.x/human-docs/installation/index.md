# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or newer**, with the **DOM** extension (`ext-dom`) enabled.
- The contrib **Diff** module (`drupal/diff` ^2.0) — Diff Plus extends it, so it
  must be present and enabled.
- The **`caxy/php-htmldiff`** PHP library (^0.1.14) — used by the Visual Inline
  (HTML5) diff. Composer pulls this in for you.

## Install with Composer

From the project root:

```bash
composer require drupal/diff_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Diff module
and the `caxy/php-htmldiff` library along with any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/diff_plus -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en diff_plus -y
```

This also enables the `diff` dependency if it isn't already on.

## Next steps

Diff Plus's comparison formats are Diff layout plugins, so after enabling the
module go to the **Diff module's settings** at
`/admin/config/content/diff/settings` and turn on the *Raw HTML* and *Visual
Inline (HTML5)* layouts. See [the overview](../index.md) for how to use them and
tune the settings.
