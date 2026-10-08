# Installation

## Requirements

Taxonomy Class is intentionally lightweight. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module enabled — the class field is added to taxonomy terms,
  so Taxonomy must be on (it is part of the standard install profile).

There are no third‑party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_class -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_class -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_class -y
```

That's all it takes. Enabling the module adds the **CSS class(es)** base field to
every taxonomy term immediately.

## After enabling

There is no configuration form. To start using it:

1. Grant the **Administer taxonomy classes** permission (under **People →
   Permissions**) to the roles that should be able to set term classes — the field
   is hidden from anyone without it.
2. Edit a term and fill in the class under the **Taxonomy Class settings** group in
   the advanced sidebar.

See the [overview](../index.md) for the full step‑by‑step.
