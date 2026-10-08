# Installation

## Requirements

Scripture Filter is lightweight:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- No other module dependencies, and no extra PHP or third-party library
  requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/scripturefilter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scripturefilter -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scripturefilter -y
```

Enabling the module makes the filter available, but it does nothing until you turn
it on within a text format.

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a text format, and confirm that a Scripture
Filter option appears in that format's list of filters. See
[Configuration](../configuration/index.md) to enable it and pick your Bible.
