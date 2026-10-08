# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module enabled (it is part of the standard Drupal install).
- The **Select or Other** module (`drupal/select_or_other`, `^4.1`) — Composer
  pulls this in automatically, and Drupal enables it as a dependency. It powers the
  feed's copyright field, which lets you choose a View field or type a literal
  string.

## Install with Composer

From the project root:

```bash
composer require drupal/podcast -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve and update the
`select_or_other` dependency and any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/podcast -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en podcast -y
```

Drupal will enable **Select or Other** at the same time because it's a dependency.

There are no submodules and no permissions to grant. Once the module is on, the
new *Podcast RSS Feed* style and *Podcast Fields* row become available whenever you
add a Feed display to a View — see [Configuration](../configuration/index.md).
