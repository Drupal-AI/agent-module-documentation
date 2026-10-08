# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other module dependencies — it uses only core's entity and field APIs — and no
  third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_back_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_back_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_back_reference -y
```

## Verify it worked

This is a library module, so there is nothing to see in the UI. Enabling it simply
registers the `entity_back_reference.back_reference_finder` service. To confirm it is
available, run `drush php:eval "var_dump(\Drupal::hasService('entity_back_reference.back_reference_finder'));"`
— it should print `true`. From there, inject or fetch that service from your own
code to perform reverse-reference lookups (see the module's README for examples), and
remember to re-apply entity access before displaying any results to end users.
