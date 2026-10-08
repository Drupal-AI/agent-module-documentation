# Installation

## Requirements

File Image Formatter needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **File** module (`file`), which Drupal enables automatically as a
  dependency. Core's Image module handles the actual image rendering.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_image_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_image_formatter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_image_formatter -y
```

## Verify it worked

Edit a **File** field's display under **Structure → Content types → *(type)* →
Manage display** (or in the relevant view). The **File Image Formatter** image
formatter should now be available in the format dropdown, and choosing it renders
image files as images.
