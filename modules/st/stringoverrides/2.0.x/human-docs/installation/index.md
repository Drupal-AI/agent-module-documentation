# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no dependent modules and no third-party Composer or PHP library
requirements. It uses Drupal's built-in string-translation system, so it works
on monolingual sites too — you do not need the multilingual modules enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/stringoverrides -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/stringoverrides -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en stringoverrides -y
```

## After enabling

Grant the **Administer string overrides** permission to the roles that should be
allowed to change interface text, then go to **Configuration → Regional and
language → String Overrides** to add your first override. See
[Configuration](../configuration/index.md).
