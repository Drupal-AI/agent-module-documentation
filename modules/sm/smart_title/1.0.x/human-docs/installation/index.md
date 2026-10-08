# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies, no PHP version requirement, and no
third-party Composer libraries. Smart Title works with any entity type that has a
*Manage display* form and a label, and plays well with Field Layout — but it is
**not** intended for Layout Builder-enabled displays (it bows out when Layout
Builder is on for a display).

## Install with Composer

From the project root:

```bash
composer require drupal/smart_title -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_title -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_title -y
```

## Enable the UI submodule (recommended)

The core module has no admin page — the point-and-click screen for choosing which
bundles are eligible lives in the **Smart Title UI** submodule (`smart_title_ui`).
Enable it too so you can manage eligible bundles at
`/admin/config/content/smart-title`:

```bash
drush en smart_title_ui -y
```

Once your bundles are opted in, you configure the actual title display on each
view mode's *Manage display* page — see [the index page](../index.md). A
production site that already has its bundles configured only needs the core
`smart_title` module; the UI submodule is only required for changing the eligible
bundle list.
