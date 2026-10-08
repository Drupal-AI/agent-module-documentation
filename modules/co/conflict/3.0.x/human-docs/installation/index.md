# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no required
contrib dependencies. The optional `conflict_paragraphs` submodule additionally
needs the Paragraphs module.

## Install with Composer

From the project root:

```bash
composer require drupal/conflict -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/conflict -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conflict -y
```

Once enabled, Conflict protects concurrent edits automatically using the default
inline resolution UI — there is nothing you must configure. To adjust the
resolution strategy, see [Configuration](../configuration/index.md).

## Submodule — Paragraphs support

If your site uses Paragraphs, enable the submodule to extend conflict handling to
paragraph fields:

```bash
drush en conflict_paragraphs -y
```

It requires the base Conflict module (already present) and the Paragraphs module.
