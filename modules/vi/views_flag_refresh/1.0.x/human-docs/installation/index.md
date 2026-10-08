# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Views** module enabled.
- The contributed **Flag** module (`drupal/flag`, `^4.0@beta || ^5.0`) — this is a
  hard dependency and Composer will pull it in.

## Install with Composer

From the project root:

```bash
composer require drupal/views_flag_refresh -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the Flag module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/views_flag_refresh -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_flag_refresh -y
```

Drupal will enable **Flag** and **Views** as dependencies if they aren't already
on. There's no settings page — the **Refresh view by Flag** option now appears in
the *Other* section of any View display. See the [overview](../index.md) for how
to configure it (and remember the display's *Use AJAX* option must be *Yes*).
