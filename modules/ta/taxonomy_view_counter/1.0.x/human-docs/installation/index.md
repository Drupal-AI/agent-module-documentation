# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** (`views`) and **Taxonomy** (`taxonomy`) modules — both ship
  with Drupal and are enabled automatically as dependencies.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_view_counter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_view_counter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_view_counter -y
```

Counting begins automatically once the module is enabled — there is no required
configuration.

## Grant the permission

The module provides its own permission. Visit **People → Permissions** and grant
it to the roles that should be able to see or work with the view counts.

## Verify it worked

Visit a taxonomy term page a few times, then build or edit a view of taxonomy
terms and confirm the module's **view count** field is available to add and that
the number rises as the term page is visited.
