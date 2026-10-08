# Installation

## Requirements

- **Drupal 9.3 or newer** (`core_version_requirement: ^9.3 || ^10 || ^11`); the
  maintainers recommend Drupal 10.3+ or 11.
- **PHP 8.1 or higher**.
- Core **File** module (`file`) — enabled automatically as a dependency.
- A modern, WebGL-capable browser for the viewer.

The JavaScript viewer stack (Cornerstone.js, DICOM Parser, Hammer.js) ships with
the module.

## Install with Composer

Installing with Composer is recommended so the module's class and namespace
mappings initialize correctly. From the project root:

```bash
composer require drupal/dicom_visualization -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dicom_visualization -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dicom_visualization -y
```

## Verify it worked

After enabling, the DICOM formatters become available on File fields, and the
global settings page appears at `/admin/dicom-configuration`. To see a viewer in
action you'll need to allow the `.dcm` extension on a File field and set its
formatter — see [Configuration](../configuration/index.md).

> **Reminder:** Before uploading real medical images, point the File field at a
> **private file scheme** with appropriate access control, since DICOM files can
> contain patient identifiers.
