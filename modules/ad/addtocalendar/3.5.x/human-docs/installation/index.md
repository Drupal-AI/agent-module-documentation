# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **Datetime** module (`datetime`) — enabled automatically as a dependency, since
  the button attaches to Date/time and Datetime Range fields.

There are no third‑party Composer or PHP library requirements. The button's JavaScript is
loaded at runtime from addtocalendar.com, so nothing needs to go into `/libraries`.

## Install with Composer

From the project root:

```bash
composer require drupal/addtocalendar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/addtocalendar -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en addtocalendar -y
```

There are no submodules and no settings page. Once enabled, go to a bundle's **Manage
display** and turn on the button for a date field, or add the standalone Add‑to‑Calendar
field — see [How to use it](../index.md#how-to-use-it) on the overview page.
