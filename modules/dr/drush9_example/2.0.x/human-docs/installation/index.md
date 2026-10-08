# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush 9 or later**, since the whole point of the module is to demonstrate the
  modern Drush command structure.

There are no third-party Composer or PHP library requirements, and no other
module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/drush9_example -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/drush9_example -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en drush9_example -y
```

Enable this on a **development environment** only — it is example code for
developers, not something to run in production.

## Verify it worked

After enabling, run `drush list` and look for the module's example command in the
output, or open the module's source directory and read the command class. Once you
have copied what you need into your own module, disable this one with
`drush pmu drush9_example -y`.
