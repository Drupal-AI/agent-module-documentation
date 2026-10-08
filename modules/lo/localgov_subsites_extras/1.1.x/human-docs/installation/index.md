# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core **Menu UI** (`menu_ui`) and **Node** (`node`) — Drupal enables these as
  dependencies.
- A **LocalGov Drupal** site with the base **subsites** functionality present — this
  module extends it, and by default works with the `localgov_subsites` content types
  and fields.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_subsites_extras -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_subsites_extras -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_subsites_extras -y
```

## Verify it worked

Create a subsite overview page, choosing a colour theme and a menu link in the
**subsites** menu. View the page and inspect its markup — the `<body>` tag should
carry the `subsite-extra` and `subsite-extra--color-x` classes. Add a child page under
it (via the menu **Parent link**) and confirm it inherits the same classes. Then place
a menu block for the **subsites** menu to see the subsite navigation.
