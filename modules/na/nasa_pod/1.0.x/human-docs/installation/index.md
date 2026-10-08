# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- No other contrib modules are required.
- The module includes its own styling library (`nasa_pod/nasa_pod_library`), which
  is attached automatically to its output — nothing to install separately.
- Outbound network access from your server to `https://api.nasa.gov` so the module
  can fetch the daily picture.

## Install with Composer

From the project root:

```bash
composer require drupal/nasa_pod -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/nasa_pod -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en nasa_pod -y
```

There is no configuration step — the module works immediately using its built-in
default NASA API key.

## Verify it worked

Visit **`/nasa/pic-of-the-day`**. You should see today's Astronomy Picture of the
Day with its image (or video), date, and explanation. Then, if you want it in a
region, place the **NASA Pic of the Day** block from **Structure → Block layout**.

For usage details and the note about the API key, see the
[overview](../index.md).
