# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Filter** module (`filter`) — enabled in every standard install; it
  provides the text formats this module chooses between.
- Core's **Field UI** module to edit the setting on Manage display (needed to
  configure it, not a hard dependency of the module).

There are no third-party PHP library requirements, no permissions of its own, and
no Drush commands.

## Install with Composer

From the project root:

```bash
composer require drupal/field_formatter_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/field_formatter_filter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_formatter_filter -y
```

## Next steps

There is nothing to configure globally. Head to the [overview](../index.md) and
follow **How to use it** to add an additional text format to a field's formatter
on the Manage display tab.
