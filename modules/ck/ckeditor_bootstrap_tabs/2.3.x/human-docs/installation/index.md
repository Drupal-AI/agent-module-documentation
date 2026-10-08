# Installation

## Requirements

- **Drupal 9.3, 10 or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core's **CKEditor 5** module (`ckeditor5`) enabled — the only dependency, and
  Drupal enables it automatically as a dependency when you turn on this module.
- A **Bootstrap-based theme** (or your own Bootstrap tab CSS) to style the rendered
  tabs. The module produces Bootstrap-compatible markup but does not ship the
  Bootstrap CSS framework itself.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_bootstrap_tabs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_bootstrap_tabs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_bootstrap_tabs -y
```

## Next step

Enabling the module makes the button available but does not add it to any editor.
Add the **Bootstrap Tabs** button to a text format's CKEditor 5 toolbar and allow
its markup — see [How to use it](../index.md#how-to-use-it) on the overview page.
