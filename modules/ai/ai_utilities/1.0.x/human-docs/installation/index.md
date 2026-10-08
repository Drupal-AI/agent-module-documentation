# Installation

## Requirements

- **Drupal 10** (`core_version_requirement: ^10`).
- No other module dependencies — it depends on no contrib modules, and it makes no
  external or network calls of its own.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_utilities -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ai_utilities -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_utilities -y
```

That is all there is to it. There is no configuration form and no permissions to
grant — enabling the module makes the `ai_utilities.format` service available for
other modules and custom code to use.
