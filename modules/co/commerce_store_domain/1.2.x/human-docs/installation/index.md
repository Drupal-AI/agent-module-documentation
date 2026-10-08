# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **Drupal Commerce** (`drupal/commerce ~2 || ^3`), including its **Store**
  submodule (`commerce_store`) — both required and enabled as dependencies.
- Optional: the contrib **Domain** module (`drupal/domain`). If it is enabled,
  this module automatically switches to Domain‑based negotiation and adds a domain
  reference field (see the Configuration guide). It is not required.
- There are no other third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/commerce_store_domain -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/commerce_store_domain -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en commerce_store_domain -y
```

Enabling the module adds a **Domain** field to the Commerce store entity and
registers the domain‑based store resolver.

## After enabling

There is no settings page and no submodules. The next step is to assign a domain
to each of your stores on the store edit form — see
[Configuration](../configuration/index.md).
