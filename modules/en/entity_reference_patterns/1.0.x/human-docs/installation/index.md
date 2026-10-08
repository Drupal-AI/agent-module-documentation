# Installation

## Requirements

- **Drupal 10.6, 11.3, or 12** (`core_version_requirement: ^10.6 || ^11.3 || ^12`).
  This is a recent‑core module, so make sure your site is up to date.
- The contributed **Token** module (`token`) — patterns are token strings, so this
  is a required dependency. Composer pulls it in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_reference_patterns -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Token and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_reference_patterns -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_reference_patterns -y
```

This also enables Token if it wasn't already. The module ships no submodules. Once
enabled, create your first pattern at *Configuration → Search and metadata →
Entity reference patterns* — see the [main guide](../index.md#how-to-use-it).
