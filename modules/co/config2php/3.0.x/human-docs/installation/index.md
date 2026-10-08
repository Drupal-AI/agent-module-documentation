# Installation

## Requirements

- **Drupal 8.7.7 or newer** (`core_version_requirement: >=8.7.7`).
- Core's **Configuration** module (`config`) — a dependency, enabled
  automatically.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config2php -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config2php -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config2php -y
```

After enabling, grant the module's export permission (**People → Permissions**)
only to trusted developers, since the exported PHP can contain sensitive
configuration values.

## Verify it worked

Open the Config2PHP tool page as a user with its permission, select a
configuration type and element, and confirm it produces a PHP array of that
configuration.
