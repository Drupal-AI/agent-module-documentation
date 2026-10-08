# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3 ||
  ^11`).
- Core's **Field** module (`field`) — Drupal enables it automatically as a
  dependency, and it is enabled on virtually every site already.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/plugin_configuration_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/plugin_configuration_field -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en plugin_configuration_field -y
```

## Verify it worked

Go to **Structure → Content types → *(any type)* → Manage fields** and click
**Add field**. If **Plugin Configuration Field** appears in the list of available
field types, the module is installed and ready to use.
