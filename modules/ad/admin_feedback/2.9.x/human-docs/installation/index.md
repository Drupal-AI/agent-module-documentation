# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Views**, **User**, and **Node** modules — all part of a standard install and
  enabled automatically as dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_feedback -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_feedback -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_feedback -y
```

There are no submodules. On install the module grants the **give feedback** permission to
both the anonymous and authenticated roles, so visitors can vote right away. Continue to
[Configuration](../configuration/index.md) to place the widget block, adjust the wording,
and review the dashboards and permissions.
