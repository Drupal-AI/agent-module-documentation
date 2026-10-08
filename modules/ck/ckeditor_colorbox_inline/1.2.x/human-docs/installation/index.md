# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Colorbox** module (`drupal/colorbox`, `^2.1`) — required. It provides the
  actual lightbox library, styling, and settings.

There are no other Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor_colorbox_inline -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Colorbox and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ckeditor_colorbox_inline -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor_colorbox_inline -y
```

This enables Colorbox too if it isn't already on. There are no submodules.

## Turn it on

Enabling the module does nothing by itself — you must enable the **Colorbox Inline
Text Filter** on each text format where you want images to open in a lightbox. See
[How to use it](../index.md#how-to-use-it) on the main page for the steps.
