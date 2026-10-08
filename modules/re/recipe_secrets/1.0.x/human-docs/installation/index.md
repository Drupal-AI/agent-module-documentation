# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Drupal's **recipe** system (part of core on these versions) — this module
  hooks into the configuration import that a recipe drives.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/recipe_secrets -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recipe_secrets -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recipe_secrets -y
```

Enable Recipe Secrets **before** you import any recipe whose config uses the
`!secret` syntax — the placeholder replacement only happens if the module is
already active when the import runs.

## Verify it worked

Add a `!secret {{NAME}}` reference to a config file in a test recipe, put a
matching `NAME=…` line in your `.env`, and apply the recipe. Inspect the active
configuration afterwards (for example with `drush config:get`): the imported
value should be the real secret from `.env`, while the recipe file on disk still
shows only the placeholder.
