# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No modules outside Drupal core are required, and there are no third‑party PHP
  library requirements.

This is an early **alpha** release (1.0.0-alpha4) and is not covered by Drupal's
security advisory policy, so test it on a non‑production copy first.

## Install with Composer

From the project root:

```bash
composer require drupal/config_track -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_track -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_track -y
```

Recording begins as soon as the module is enabled — there is nothing to configure.

## Verify it worked

Change a configuration setting (for example edit a view or a permission and save),
then open the module's admin listing of recent config changes. Your change should
appear, attributed to your user, with a diff available. Before relying on it,
restrict who can read that history and consider storage growth, as noted on the
[overview page](../index.md).
