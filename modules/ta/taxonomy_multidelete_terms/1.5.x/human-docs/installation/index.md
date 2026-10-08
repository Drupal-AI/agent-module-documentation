# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — this is the only dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_multidelete_terms -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_multidelete_terms -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_multidelete_terms -y
```

## Grant the permission

The bulk‑delete controls only appear for users who hold the module's permission.
Grant it to the appropriate roles at **People → Permissions**
(`/admin/people/permissions`), or from the command line:

```bash
drush role:perm:add editor 'access taxonomy multidelete terms'
```

## Verify it worked

As a user with that permission, open a vocabulary's **Manage terms** page
(**Structure → Taxonomy → *(vocabulary)* → Manage terms**). Each term row should
now show a checkbox, and a **Delete** button should be available for acting on the
selected terms.
