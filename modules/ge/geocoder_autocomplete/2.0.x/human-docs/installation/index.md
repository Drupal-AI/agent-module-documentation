# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** and **Field UI** modules (standard on most sites) so you can
  place the widget on a field's *Manage form display*.
- A **Google Cloud API key** with the **Geocoding API** enabled and billing set
  up. Without a working key the widget renders but returns no suggestions.

There are no contrib module dependencies and no extra Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/geocoder_autocomplete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/geocoder_autocomplete -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geocoder_autocomplete -y
```

There are no submodules.

## Next step

Add your Google API key and attach the widget to a field — see
[Configuration](../configuration/index.md).
