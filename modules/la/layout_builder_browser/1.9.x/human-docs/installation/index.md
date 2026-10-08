# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- Core's **Layout Builder** module (`layout_builder`) enabled — this is the only
  dependency, and Drupal enables it automatically when you turn on Layout Builder
  Browser. (Layout Builder in turn needs core's Layout Discovery and Block
  modules, which Drupal also enables for you.)

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_browser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/layout_builder_browser -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_browser -y
```

You'll also want Layout Builder itself enabled on at least one content type or
view mode (**Structure → Content types → *your type* → Manage display → Layout
options**) so there's a layout to add blocks to.

Once enabled, nothing changes for editors until you build the curated palette —
see [Configuration](../configuration/index.md).

Layout Builder Browser has no submodules.
