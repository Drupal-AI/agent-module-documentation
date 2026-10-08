# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field UI** module (`field_ui`) — this is the only dependency, and
  Drupal enables it automatically when you turn on Display Mode Guidelines. (Field
  UI is what provides the display-mode management screens the module hooks into.)

There are no third-party Composer or PHP library requirements, and the module
adds no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/dmg -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dmg -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dmg -y
```

There are no submodules. Once enabled, the display-mode add/edit forms gain a
**Configuration Guidelines** field, the display-mode listings gain a
**Guidelines** column and **Set creation guidelines** action links, and the
*Manage display* forms show any stored guideline as a warning. See
[Configuration](../configuration/index.md) to start writing guidelines.
