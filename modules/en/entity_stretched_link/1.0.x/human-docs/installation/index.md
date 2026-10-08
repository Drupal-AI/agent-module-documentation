# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`) module, which ships with Drupal.

There are no third‑party Composer or PHP library requirements. Note that **no CSS
is included** — the visual stretched‑link effect relies on a `.stretched-link`
style in your theme (see the [overview](../index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_stretched_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_stretched_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_stretched_link -y
```

## Verify it worked

Go to a bundle's **Manage display** screen (for example the Teaser view mode of a
content type). A stretched‑link **extra field** should appear in the *Disabled*
section, ready to move into the visible fields. See the "How to use it" section of
the [overview](../index.md) for placing it and adding the required CSS.
