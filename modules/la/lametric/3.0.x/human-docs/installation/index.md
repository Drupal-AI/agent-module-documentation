# Installation

## Requirements

- **Drupal 8.8 or newer** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **System** module (always present).
- The contrib **Service** module (`service`), pulled in automatically when you
  install with Composer.
- A **LaMetric Time** device and a **LaMetric API token** for it (see
  [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/lametric -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Service module
and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/lametric -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en lametric -y
```

## Verify it worked

After enabling, open the module's settings and enter your LaMetric API token as
described in [Configuration](../configuration/index.md). A successful test
notification appearing on your device confirms the connection.
