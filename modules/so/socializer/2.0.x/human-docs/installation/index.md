# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No dependent modules, and no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/socializer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/socializer -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en socializer -y
```

## Verify it worked

The module adds a block. Go to **Structure → Block layout**
(`/admin/structure/block`), click **Place block**, and confirm the Socializer
block appears in the list. Place it, enter your social links, and save — you
should then see the links in the region you chose. See the
[main guide](../index.md) for details. Grant the module's permission only to
roles that should manage the links.
