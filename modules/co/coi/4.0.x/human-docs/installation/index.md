# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1 or newer**.
- **Config Override Core Fields** (`drupal/config_override_core_fields` `^4`) — a
  hard dependency that supplies the config-key hints COI reads. Composer installs
  it automatically.

The **Token** module (`drupal/token`) is an optional suggestion — it adds a token
browser to COI's settings form, but is not required.

## Install with Composer

From the project root:

```bash
composer require drupal/coi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`config_override_core_fields` dependency alongside it and update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/coi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en coi -y
```

This enables COI together with its `config_override_core_fields` dependency (which
provides coverage of the core system settings forms).

## Grant the permission

COI's settings form is gated by the **Administer config override inspector**
(`administer config override inspector`) permission:

```bash
drush role:perm:add administrator 'administer config override inspector'
```

Next, tune how COI reacts to overrides — see [Configuration](../configuration/index.md).
