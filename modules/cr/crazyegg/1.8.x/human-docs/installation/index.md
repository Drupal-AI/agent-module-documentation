# Installation

## Requirements

- **Drupal 8, 9, 10, 11, or 12** (`core_version_requirement: ^8 || ^9 || ^10 || ^11 || ^12`).
- No module dependencies and no third‑party libraries.
- A **Crazy Egg account** with your numeric account number (from your Crazy Egg
  dashboard).

## Install with Composer

From the project root:

```bash
composer require drupal/crazyegg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crazyegg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crazyegg -y
```

## Verify it worked

Go to **Configuration → System → Crazy Egg** (`/admin/config/system/crazyegg`), enter
your account number, set **Enable Crazy Egg** to *Yes*, and save (see
[Configuration](../configuration/index.md)). Then load a front-end page as an
untracked-role-excluded visitor and view the page source: you should see the Crazy Egg
script tag referencing `script.crazyegg.com`. If it isn't there, re-check that the
module is enabled, an account number is set, the current path matches your path rules,
and your role isn't in the excluded list.
