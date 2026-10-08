# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **No external dependencies** — the module needs nothing beyond Drupal core.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_manager -y
```

## Grant the permission

Because merging can rewrite references and delete content, the module ships its
own permission. After enabling, go to **People → Permissions**
(`/admin/people/permissions`) and grant the Entity Reference Manager permission
only to roles you fully trust (typically Administrator).

## Verify it worked

Log in as an administrator who has the permission, open the Entity Reference
Manager interface, and confirm you can select source and target entities and see
the pre‑execution analysis summary. Seeing that summary — before you confirm any
merge — means the module is installed and working.
