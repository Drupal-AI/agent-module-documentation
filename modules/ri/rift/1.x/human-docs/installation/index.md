# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- RIFT declares these companion modules as dependencies, so Composer will bring
  them in:
  - **[Image Widget Crop](https://www.drupal.org/project/image_widget_crop)**
    (`image_widget_crop`) — manual crop support.
  - **[Image Style Quality](https://www.drupal.org/project/image_style_quality)**
    (`image_style_quality`) — per-style quality control.
  - **[Focal Point](https://www.drupal.org/project/focal_point)** (`focal_point`)
    — set an image's point of interest.
  - **[Crop API](https://www.drupal.org/project/crop)** (`crop`) — used by Image
    Widget Crop.

## Install with Composer

From the project root:

```bash
composer require drupal/rift -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the crop/focal
point dependencies and update any shared packages as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rift -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the core module and — strongly recommended — the UI submodule that lets you
manage responsive sizes visually:

```bash
drush en rift rift_ui -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **RIFT UI** | `rift_ui` | A rich UI for configuring RIFT, with advanced validation and auto-healing of configuration. **Highly recommended** — it's the intended way to create and manage responsive sizes without writing config by hand. |
| **RIFT Starter Kit** | `rift_starter_kit` | A starting set of RIFT configuration to get you going quickly. |

## Verify it worked

Log in as an administrator. With **RIFT UI** enabled you should be able to define
Responsive Image View Modes through its interface, then select **Rift Media
Picture** (or **…with Fallback**) as the formatter on a media reference field's
**Manage display**. See the "How to use it" section of the
[overview](../index.md) for the full flow.
