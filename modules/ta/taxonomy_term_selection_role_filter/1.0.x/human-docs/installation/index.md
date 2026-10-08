# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** (`taxonomy`) module — it ships with Drupal and is enabled
  automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_term_selection_role_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_term_selection_role_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_term_selection_role_filter -y
```

After enabling, follow the setup steps in the [main guide](../index.md#how-to-set-it-up):
add a Role reference field to the vocabulary, set allowed roles on the terms, and
choose the **"Taxonomy terms with role filter"** reference method on the field you
want to filter.

## Verify it worked

Edit a taxonomy term‑reference field's settings and confirm that **"Taxonomy terms
with role filter"** now appears as an available reference method. Once configured,
log in as users with different roles and check that each is offered only the terms
their roles allow.
