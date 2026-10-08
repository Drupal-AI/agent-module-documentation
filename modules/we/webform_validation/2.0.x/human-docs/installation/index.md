# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`).
- The **Webform** module (`webform`), version **6.2 or newer** — this module extends
  Webform's element configuration, so Webform must be present. Composer installs it as
  a dependency.
- No PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_validation -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Webform if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_validation -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_validation -y
```

Enabling Webform Validation adds a **Form extra validation** section to the settings
of supported webform elements. Nothing changes on existing forms until you configure a
rule on an element — see [Configuration](../configuration/index.md).
