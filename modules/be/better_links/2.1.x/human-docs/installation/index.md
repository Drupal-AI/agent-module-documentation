# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Link** module (`link`) — Better Links extends its widget, and Drupal
  enables it automatically as a dependency.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/better_links -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/better_links -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en better_links -y
```

Enabling this also enables core Link if it was not already on. The **Better Link**
widget then becomes selectable on the **Manage form display** screen for any link
field — see [How to use it](../index.md#how-to-use-it).
