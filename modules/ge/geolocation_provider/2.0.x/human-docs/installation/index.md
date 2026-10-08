# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Serialization** (`serialization`) module.
- The module is designed to work with a **Geo‑Map field** and a **map provider**;
  install those pieces if your build needs to display or select locations. On its
  own, Geolocation Provider only supplies the plugin type — it's infrastructure
  for modules that implement or consume providers.

There are no special third‑party PHP library requirements for the module itself,
though a specific provider you use (for example a commercial API) may need its own
credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/geolocation_provider -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geolocation_provider -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geolocation_provider -y
```

Drupal will enable `serialization` alongside it if it isn't already on.

## Verify it worked

Because the module is infrastructure, the check is that its providers become
available to consumers. On a Geo‑Map field's display/settings form, you should be
able to **select a provider** (such as IGN or Nominatim) from the registered
options. If a custom module you've written registers a `GeolocationProvider`
plugin, confirm it appears there too. If the provider options are present, the
plugin type is installed and working.
