# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`). Note
  that this compatibility claim is a declaration from a 2023 release — test it on
  your actual core version rather than assuming it holds.

There are no dependencies, third-party Composer packages, or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/backward_compatibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/backward_compatibility -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en backward_compatibility -y
```

Once enabled, the restored APIs are available immediately — there is nothing to
configure. Enable it as part of a planned core upgrade, keep a list of which
removed functions your code actually relies on, and uninstall it again once you
have fixed those call sites.
