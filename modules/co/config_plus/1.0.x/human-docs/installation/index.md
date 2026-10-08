# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party Composer or PHP library requirements, and no module dependencies beyond
  core's configuration system, which is always present.

Note this is an **alpha** release (1.0.0‑alpha3) and the project is not covered by Drupal's
security advisory policy — fine for a development aid, but weigh that before relying on it in
production.

## Install with Composer

From the project root:

```bash
composer require drupal/config_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_plus -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_plus -y
```

Enabling it activates the validation constraint and the UUID fix, and makes the
`config_plus.config_installer` service available for use from your own module's
`hook_update_N()`.

## Verify it worked

There is no settings page to check. Confirm the module is enabled with:

```bash
drush pm:list --status=enabled | grep config_plus
```

From there, Config Plus works in the background — see [the main guide](../index.md) for how
to call the installer service and what the validation constraint reports.
