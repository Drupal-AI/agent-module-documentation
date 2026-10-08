# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **User** module (`user`) — enabled on every standard Drupal site.
- Optional: the core **JSON:API** module (`jsonapi`). The masked‑output JSON:API
  normalizer is only registered when JSON:API is enabled; you do not need it for
  entity‑display or Views masking.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/masked_output -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/masked_output -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en masked_output -y
```

## Verify it worked

Go to the **Manage display** tab of an entity bundle with a string, email, or
telephone field. The format drop‑down should now list the Masked Output
formatters (**Mask Output**, **Mask Email Output**, **Mask Pattern Output**).
Pick one, set its options, and view the entity — the value should render masked.
See "How to use it" in the [overview](../index.md) for the display, Views, and
permission setup.
