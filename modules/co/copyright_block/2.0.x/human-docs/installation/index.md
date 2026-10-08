# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Token** module (`token`) — the only dependency. It powers the
  `[copyright_statement:dates]` token that renders the year range. Composer
  installs it for you.

There are no third‑party Composer or PHP library requirements, and the module
adds no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/copyright_block -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Token
dependency and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/copyright_block -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en copyright_block -y
```

Drupal enables the Token dependency at the same time. There are no submodules.

## Next step

There is no settings page. Place and configure the **Copyright block** from
**Structure → Block layout** — see the [overview](../index.md) for the block form
fields and the year‑range token.
