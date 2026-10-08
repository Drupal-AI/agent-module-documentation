# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — this is the only dependency,
  and Drupal enables it automatically.

There are no third-party Composer or PHP library requirements. (The module also ships
a legacy CKEditor 4 plugin class for older editor integrations, but the current
feature targets CKEditor 5.)

## Install with Composer

From the project root:

```bash
composer require drupal/shy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/shy -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en shy -y
```

Enabling the module makes the *Soft hyphen* button and *Cleanup SHY markup* filter
*available*, but they do nothing until you add them to a specific text format. See
[Configuration](../configuration/index.md).
