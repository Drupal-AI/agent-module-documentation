# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Taxonomy** module (`taxonomy`) — Drupal enables it automatically as a
  dependency when you turn on Entity Term.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_term -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_term -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_term -y
```

## Verify it worked

Log in as a user with the **Administer Entity Term** permission and visit
**Configuration → System → Entity Term** (`/admin/config/system/entity_term`). You
should see the form for defining entity term sets. Until you add a set and save,
no terms are created — see [Configuration](../configuration/index.md) for the next
step.
