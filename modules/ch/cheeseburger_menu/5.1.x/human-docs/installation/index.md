# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Block** module (`block`) enabled — this is the only dependency, and
  Drupal enables it automatically as needed. (It's enabled on most standard sites
  already.)
- Optional: core's **Breakpoint** module if you want to restrict the trigger to
  named breakpoints; without it you can still use a custom media query.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cheeseburger_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cheeseburger_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cheeseburger_menu -y
```

There are no submodules. Enabling the module makes two blocks available —
**Cheeseburger menu** (the panel) and **Cheeseburger menu trigger** (the button).
Nothing appears on the site until you place them; head to
[Configuration](../configuration/index.md) to set them up.
