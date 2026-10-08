# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) enabled — Drupal enables it
  automatically as a dependency. You will need at least one vocabulary whose terms
  act as your access categories.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tac_lite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tac_lite -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tac_lite -y
```

## Submodule — tac_lite_create

tac_lite ships one optional submodule, **tac_lite_create** (`tac_lite_create`).
It hides the taxonomy term options a user is not allowed to use on node add/edit
forms, so editors only see the categories they may actually assign. Enable it only
if you need that behaviour:

```bash
drush en tac_lite_create -y
```

## Next steps

Enabling the module does nothing on its own — you must configure at least one
vocabulary and one scheme, then rebuild node access permissions. See
[Configuration](../configuration/index.md).
