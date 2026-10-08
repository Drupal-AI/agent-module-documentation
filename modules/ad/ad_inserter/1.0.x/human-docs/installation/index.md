# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — a dependency, enabled on standard installs
  and pulled in automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ad_inserter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ad_inserter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ad_inserter -y
```

After enabling, grant the **Administer ad inserter** (`administer ad inserter`)
permission **only to trusted full administrators** — it allows injecting
arbitrary third-party script into public pages. Then define and place your ad
units from the admin UI (see the [main guide](../index.md#how-to-use-it)).
