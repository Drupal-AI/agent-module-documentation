# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** (`taxonomy`) module — it ships with Drupal and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_term_root -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_term_root -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_term_root -y
```

The root‑term base field is available on all taxonomy terms immediately — no
per‑vocabulary configuration is needed.

## Verify it worked

Build or edit a taxonomy‑term View and confirm the root‑term field is available to
add as a field or a filter. For terms that sit under a parent, the field should
report the top‑level (root) term of their branch.
