# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on Field Time.
- The core **Field UI** module is what gives you the *Manage fields / form display /
  display* screens you'll use to add and configure the fields.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_time -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_time -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_time -y
```

## Next steps

Enabling the module makes the **Time** and **Time Range** field types available in
the Field UI. Add one to a bundle and configure its widget and formatter — see
[Configuration](../configuration/index.md).
