# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Image Widget Crop** (`image_widget_crop`) — the module Crop Image extends.
- **Entity Browser** (`entity_browser`) **version 2.10 or later** — used for the
  browse-and-select experience.

Both are Drupal modules pulled in via Composer. There are no third-party PHP library
requirements. (See the note on the [overview](../index.md) about whether Entity
Browser is the right fit for a site already on the core Media Library.)

## Install with Composer

From the project root:

```bash
composer require drupal/crop_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Image Widget Crop,
Entity Browser, and any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crop_image -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crop_image -y
```

Drupal will enable Image Widget Crop and Entity Browser alongside it if they aren't
already on.

## Verify it worked

Go to a bundle with an image field, open its **Manage form display**, and check that
**ImageWidget crop (with browser)** is available as a widget for that field.
Selecting it confirms the module is active — see "How to use it" in the
[overview](../index.md).
