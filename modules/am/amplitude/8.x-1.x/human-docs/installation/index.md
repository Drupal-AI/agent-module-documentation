# Installation

## Requirements

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- The **Token** module (`token`), which the event properties use for
  token replacement. Install it if it is not already present.
- An **Amplitude** account and a project **API key** (the public client-side
  key).

## Install with Composer

From the project root:

```bash
composer require drupal/amplitude -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Token if it is missing.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/amplitude -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en amplitude -y
```

After enabling, enter your Amplitude API key and define your tracking events on
the settings form — see [Configuration](../configuration/index.md).
