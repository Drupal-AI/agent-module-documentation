# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Drush** to run the extraction command (`drush cec`).

There are no third-party Composer or PHP library requirements, and no Drupal
module dependencies. (Some built-in extractors read configuration from optional
modules — Views, Display Suite, Layout Builder, Filter — but these are not
required for the module to install and run.)

## Install with Composer

From the project root:

```bash
composer require drupal/classes_extractor
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/classes_extractor`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en classes_extractor -y
```

## Verify it worked

1. Open the settings form at **`/admin/config/classes-extractor`** and set a
   writable **file path** (see [Configuration](../configuration/index.md)).
2. Run the extraction:

   ```bash
   drush cec
   ```

   It collects the CSS classes from your configuration and writes them to that
   file, printing a confirmation line.

You can also confirm the JSON route responds by requesting
`GET /api/v1/classes-extractor` as a user with the *Administer site configuration*
permission; it returns the classes as JSON.
