# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (any site with vocabularies already has it). There are no
  other module or PHP library dependencies.

Note this project is **not covered by Drupal's security advisory policy**, so review it
accordingly before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_search_admin_form -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_search_admin_form -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_search_admin_form -y
```

## Grant the permission

The module provides its own permission gating access to the search form. Go to
**People → Permissions** (`/admin/people/permissions`) and grant it to the roles that
should be able to search taxonomy terms.

## Verify it worked

As a user with the permission, open the taxonomy term search form and type a term
name — matching terms from across all vocabularies should be listed.
