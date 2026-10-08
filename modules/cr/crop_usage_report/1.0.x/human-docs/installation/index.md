# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core **Media** (`media`) and **File** (`file`) modules.
- The **Crop** module (`crop`).
- **Image Widget Crop** installed, enabled, and configured for your media images —
  this is the cropping workflow the report audits. (It isn't a hard module
  dependency, but the report is only meaningful once your images are set up to be
  cropped with it.)

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/crop_usage_report -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Crop module and
any other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crop_usage_report -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crop_usage_report -y
```

Core Media and File and the Crop module will be enabled alongside it if they aren't
already on.

## Verify it worked

Log in as an administrator, grant yourself the **view crop usage report** permission
at **People → Permissions**, then visit **Reports → Crop usage**
(`/admin/reports/crop-usage`). You should see the report listing your media images
and their crop coverage. See "How to use it" in the [overview](../index.md).
