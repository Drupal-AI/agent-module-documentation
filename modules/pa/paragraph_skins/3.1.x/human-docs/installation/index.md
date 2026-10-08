# Installation

## Requirements

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`), which is the only dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraph_skins -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraph_skins -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraph_skins -y
```

## Verify it worked

Define at least one skin in a `*.paragraph_skins.yml` file (see the
[overview page](../index.md#how-to-use-it) for the format) and clear the cache
(`drush cr`). Then edit a paragraph of the bundle you targeted — a **skin select
field** should appear on the form, offering the skin(s) you defined for that bundle.
