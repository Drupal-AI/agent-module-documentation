# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Field Group** module (`drupal/field_group` `^3.4 || ^4.0`) enabled — this
  is a required dependency, since the whole point of the module is to override a
  field group's label. Composer pulls it in automatically with the command below.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/field_group_label -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Field Group
module (and any shared dependencies) alongside this one.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_group_label -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_group_label -y
```

Enabling it also enables Field Group if it wasn't already on. The **Field Group
Label** field type is then available on every fieldable bundle's **Add field**
screen. There is no configuration form; see the
[overview](../index.md#how-to-use-it) for how to add the field and wire it to a
group.
