# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 | ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- The **Colorbox** module (`drupal/colorbox ^2.0`) — the lightbox library
  integration this module builds on. Composer pulls it in automatically.
- For the `colorbox-inline` and `colorbox-node` styles you also need Colorbox's
  matching submodules enabled; for token support in a manual link URL you need
  the Token module.

## Install with Composer

From the project root:

```bash
composer require drupal/colorbox_field_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and installs the required Colorbox module alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/colorbox_field_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en colorbox_field_formatter -y
```

Drupal enables Colorbox automatically as a dependency. Once enabled, the three
"Colorbox FF" formatters appear on the **Manage display** screens for fields of
the matching types — see the [overview](../index.md#how-to-use-it) for how to
assign and configure them. There is no separate configuration page.
