# Installation

## Requirements

- **Drupal 9.2, 10 or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Node** (`node`) and **Taxonomy** (`taxonomy`) modules — Drupal enables
  them as dependencies. They are what enhanced data capture reads content type and
  term metadata from.
- A **VWO (Visual Website Optimizer) account** and its account ID — the module wires
  Drupal to VWO, so you need the account for it to do anything.

There are no extra PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_vwo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_vwo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_vwo -y
```

## Next steps

Nothing runs on the front end until you enter your VWO account ID and choose where
the script loads. Head to [Configuration](../configuration/index.md) to set the
account ID and visibility, assign the permission, and read the consent/privacy
notes before going live.
