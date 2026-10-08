# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Update Manager** module (`update`), which the module depends on and which
  standard Drupal sites already run.

There are no third-party PHP libraries or external services to install.

## Install with Composer

From the project root:

```bash
composer require drupal/site_key_mutator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site_key_mutator -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site_key_mutator -y
```

## Verify it worked

The module works transparently: once enabled, it anonymizes the unique site key on the
core Update module's requests — either removing it or replacing it with a random value.
There is no dashboard to check; simply keeping the module enabled keeps the identifier
out of (or randomized in) Drupal's update telemetry.
