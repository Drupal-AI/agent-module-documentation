# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2||^10||^11`).
- No module dependencies beyond Drupal core, and no third-party Composer or PHP
  libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/suppress_logs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/suppress_logs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en suppress_logs -y
```

Enabling the module changes nothing on its own — no channels are suppressed until
you list them on the settings form. See [Configuration](../configuration/index.md).

## Verify it worked

As an administrator, go to the module's **Suppress Logs settings form** under
**Configuration**. You should see the form where you add the log channels to
ignore.
