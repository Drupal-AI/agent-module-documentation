# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- No other Drupal modules or third-party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/advance_script_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advance_script_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advance_script_manager -y
```

## Grant the permission carefully

Enabling the module is not enough to use it — you also need the
`advance_script_manager_settings` permission. This permission is **restricted**
because it allows arbitrary code injection (see the warning in
[Configuration](../configuration/index.md)). Grant it on **People → Permissions**
to fully trusted administrator roles only, and never to content editors. No
scripts run until you add one and explicitly enable it.
