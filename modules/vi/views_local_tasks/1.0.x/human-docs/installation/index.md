# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Views** module (`views`) enabled.
- Core's **Menu UI** module recommended — the tab's *parent* selector and the
  extra menu fields only appear when Menu UI is enabled.

There are no third-party Composer libraries or contrib dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/views_local_tasks -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_local_tasks -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_local_tasks -y
```

If Menu UI is not already on, enable it too so the extra tab options appear:

```bash
drush en menu_ui -y
```

## What to do next

The module adds extra menu options to any Views **Page** display whose menu type
is **Tab**. Head to **Structure → Views**, edit a page display, and set its menu
to *Tab* to reveal them — see [How to use it](../index.md#how-to-use-it) for the
steps. Remember to run `drush cr` after changing tab settings.
