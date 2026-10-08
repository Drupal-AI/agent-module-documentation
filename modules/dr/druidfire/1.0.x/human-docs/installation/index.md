# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Drush** — required for the command‑line operations.
- Optional dependencies, only for the transformations that need them:
  - **Bricks** — required for the `err2bricks` spell (Entity Reference Revisions →
    Bricks).
  - **Paragraphs** — typically needed when working with Entity Reference Revisions
    fields.
  - **Taxonomy** (in core) — required for the `string2taxonomyReference` spell.

The module works with standard Drupal field types and needs no external libraries
or APIs.

## Install with Composer

From the project root:

```bash
composer require drupal/druidfire -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/druidfire -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en druidfire -y
```

## Verify it worked

Run the spell listing to confirm Druidfire is available:

```bash
drush druidfire:list-spells
```

You should see the list of available transformations. Remember to **back up your
database** before running any actual field transformation — see "How to use it" in
the [overview](../index.md).
