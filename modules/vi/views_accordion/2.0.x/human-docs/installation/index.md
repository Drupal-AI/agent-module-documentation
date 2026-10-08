# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Views** module (`views`), which is enabled by default on most sites.
- The contributed **jQuery UI Accordion** module (`drupal/jquery_ui_accordion`
  `^2.0`), which supplies the jQuery UI Accordion library. Composer installs it as
  a dependency.
- No third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/views_accordion -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in `jquery_ui_accordion`.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/views_accordion -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en views_accordion -y
```

Drupal enables the `jquery_ui_accordion` dependency at the same time. The module
ships **no submodules** and adds no configuration of its own — the accordion style
simply becomes available as a **Format** option inside Views.

## Next steps

Edit a view, set its Format to **jQuery UI accordion**, and configure the style —
see the [overview](../index.md#how-to-use-it) for the full walkthrough.
