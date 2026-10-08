# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Text** module (`text`) — enabled automatically as a dependency.
- **The [Token](https://www.drupal.org/project/token) module, version 1.1 or
  newer** (`drupal/token:^1.1`). Document titles are built from tokens, so this is
  required — Composer pulls it in for you.

There are no other third-party Composer or PHP library requirements.

Optional: if you enable core's **Language / Content Translation** modules, document
titles, bodies, and acceptance labels become translatable per language.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_legal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install or update the Token
dependency and any shared libraries as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_legal -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_legal -y
```

## Right after enabling

Grant the **Administer entity legal** permission to your administrator role at
*People → Permissions* so you can reach *Structure → Legal documents* and start
creating documents. Note that each document you create will generate its own *view*
and *re-accept* permissions — you'll typically want to grant those too (see the
[Configuration](../configuration/index.md#permissions) page).

This module has no submodules.
