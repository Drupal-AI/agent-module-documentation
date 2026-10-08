# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **AWeber account** with a mailing list / sign‑up form to embed.

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/aweber_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aweber_block -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aweber_block -y
```

Once enabled, place the AWeber block from **Structure → Block layout** and connect
it to your AWeber list — see [How to use it](../index.md#how-to-use-it) on the
overview page. If the block needs an AWeber API credential, store it as an
environment variable (never in committed config), as described there.
