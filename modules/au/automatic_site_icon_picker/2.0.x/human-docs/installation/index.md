# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), enabled automatically as a dependency.
- **Outbound network access** — displaying a link's icon involves requesting the
  destination site's favicon.

## Install with Composer

From the project root:

```bash
composer require drupal/automatic_site_icon_picker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/automatic_site_icon_picker -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en automatic_site_icon_picker -y
```

The module ships no submodules. Once enabled, the favicon formatter becomes
available on any Link field's **Manage display** screen — see
[How to use it](../index.md#how-to-use-it).
