# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A **Flockler** account with a configured feed, and its embed/feed identifier.
- No third-party Composer or PHP library requirements, and no other module
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/flockler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flockler -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flockler -y
```

## Verify it worked

Go to **Structure → Block layout** and confirm a **Flockler** feed block is
available to place. Placing it and entering your feed identifier (see
[Configuration](../configuration/index.md)) should render your Flockler feed on the
page.
