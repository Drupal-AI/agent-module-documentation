# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The contrib **[Token](https://www.drupal.org/project/token)** module (`token`,
  `^1.9`) — Drupal enables it automatically as a dependency.
- Three third-party PHP libraries, pulled in automatically by Composer:
  - **`seboettg/citeproc-php` `^2.6`** — renders CSL-JSON into formatted
    citations.
  - **`professional-wiki/edtf` `^3.1`** — parses EDTF (Extended Date/Time Format)
    date fields.
  - **`adci/full-name-parser` `^0.2.4`** — splits author names into given/family
    parts.

## Install with Composer

From the project root — Composer resolves the citation libraries and Token for
you:

```bash
composer require drupal/citation_select -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/citation_select -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en citation_select -y
```

There are no submodules. Once enabled, head to
[Configuration](../configuration/index.md) to place the block and map your fields —
the module needs that mapping before it can produce a citation.
