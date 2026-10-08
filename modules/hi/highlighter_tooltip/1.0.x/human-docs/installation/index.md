# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Path Alias** (`path_alias`) module — Drupal enables it automatically
  as a dependency.

There are no third‑party Composer or PHP library requirements; the tooltip's
JavaScript and CSS ship with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/highlighter_tooltip -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/highlighter_tooltip -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en highlighter_tooltip -y
```

## Verify it worked

Visit any front‑end page and select (highlight) a passage of text. A small tooltip
should appear offering to copy a shareable URL to the clipboard. There is no
configuration required — see "How to use it" in the [overview](../index.md) for
the optional developer‑level customisation.
