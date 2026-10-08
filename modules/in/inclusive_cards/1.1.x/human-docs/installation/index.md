# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No third‑party Composer packages or PHP libraries are required.

To get anything on screen you will also want a **View** that renders content in
a teaser (or similar) view mode — that is what produces the cards this module
enhances — but that uses core's Views module, which is already part of Drupal.

## Install with Composer

From the project root:

```bash
composer require drupal/inclusive_cards -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/inclusive_cards -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en inclusive_cards -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → System → Inclusive Cards**
(`/admin/config/system/inclusive-cards`). If the settings page loads and lists
your node and taxonomy view modes, the module is installed. Continue to
[Configuration](../configuration/index.md) to choose which view modes get the
accessible-card behaviour.
