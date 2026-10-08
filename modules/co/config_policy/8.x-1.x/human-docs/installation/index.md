# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`) — Drupal enables it automatically as a dependency (and
  it is on for virtually every site already).

There are no third‑party Composer or PHP library requirements. Note this is an **alpha**
release (8.x‑1.4‑alpha4) and the project is not covered by Drupal's security advisory
policy — weigh that before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/config_policy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_policy -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_policy -y
```

## Verify it worked

Confirm the Drush command is available:

```bash
drush config-policy:validate --help   # or: drush cpv --help
```

If the command is recognised, the module is installed. From there, open the Config Policy
management UI to create your first policy and add rules — see
[the main guide](../index.md) for the workflow, and remember to run `drush cpv` in CI to
enforce your policies automatically.
