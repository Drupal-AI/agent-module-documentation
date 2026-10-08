# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`) enabled — the only dependency, and Drupal
  enables it automatically.
- No third-party PHP or Composer libraries.
- The contrib **Domain** module is **optional** — install it only if you want to hide
  the toolbar per domain as well as per theme.

## Install with Composer

From the project root:

```bash
composer require drupal/toolbar_visibility -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/toolbar_visibility -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en toolbar_visibility -y
```

Enabling the module changes nothing until you choose the themes to hide the toolbar on.
Grant the **Administer toolbar visibility** permission to the relevant roles at
**People → Permissions**, then see [Configuration](../configuration/index.md).
