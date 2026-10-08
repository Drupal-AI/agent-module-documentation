# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 7.1 or newer** (`php: >=7.1`).
- The **Inline Entity Form** module (`drupal/inline_entity_form` `^1 || ^3`),
  enabled — this module extends its Complex widget and is pulled in as a Composer
  dependency.

There are no other third-party Composer requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ief_popup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer also install Inline Entity
Form and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ief_popup -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ief_popup -y
```

If Inline Entity Form is not already on, enable it too (`drush en
inline_entity_form -y`).

## Next steps

Enabling the module does not change any form yet — you switch the popup on per
field widget. See [Configuration](../configuration/index.md).
