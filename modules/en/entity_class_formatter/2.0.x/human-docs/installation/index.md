# Installation

## Requirements

Entity Class Formatter is lightweight. It needs:

- **Drupal 9.5, 10, 11, or 12**
  (`core_version_requirement: ^9.5 || ^10 || ^11 || ^12`).
- Core's **Field** module (`field`) enabled — this is the only dependency, and it is part of
  a standard Drupal install.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_class_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_class_formatter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_class_formatter -y
```

There is no configuration to do here — the **Entity Class** formatter is now available on
*Manage display* pages for the supported field types. See the [overview](../index.md#how-to-use-it)
for how to apply it to a field.
