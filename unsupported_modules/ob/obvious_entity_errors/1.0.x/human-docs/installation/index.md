# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements.

> **Note on names:** the project is **`oee`** on drupal.org, so you install it with
> `composer require drupal/oee`, but the module's machine name — the one you enable
> with Drush — is **`obvious_entity_errors`**.

## Install with Composer

From the project root:

```bash
composer require drupal/oee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oee -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en obvious_entity_errors -y
```

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep obvious_entity_errors
```

From then on, any entity definition or schema mismatch on your site will be
surfaced prominently in the admin — no further setup required.
