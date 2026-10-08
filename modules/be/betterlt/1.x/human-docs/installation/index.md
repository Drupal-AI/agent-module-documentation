# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No other module dependencies, and no PHP library or Composer requirements.

## Install with Composer

From the project root, require the project by its short name:

```bash
composer require drupal/betterlt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/betterlt -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

The Composer package is `drupal/betterlt`, but the **module machine name is
`better_local_tasks`** — use that when enabling:

```bash
drush en better_local_tasks -y
```

The refined tab styling is active immediately across the site. There is no
configuration and no permission to grant.
