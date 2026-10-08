# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- The [Mapkit](https://www.drupal.org/project/mapkit) module (`mapkit`) — this is
  a provider for that framework, so Mapkit must be present.
- The [Toolshed](https://www.drupal.org/project/toolshed) module (`toolshed`), a
  required dependency (also required by Mapkit).
- A **Google Cloud project** with the Maps JavaScript API enabled and a browser
  API key. See
  [Get an API key](https://developers.google.com/maps/documentation/javascript/get-api-key).

Composer pulls in Mapkit and Toolshed with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/mapkit_gmap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the required
**Mapkit** and **Toolshed** modules and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mapkit_gmap -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mapkit_gmap -y
```

This also enables **Mapkit** and **Toolshed** if they aren't on already.

## Verify it worked

Go to **Configuration → Web services → Mapkit**
(`/admin/config/services/mapkit`) — Google Maps should now appear in the provider
list, with a link to its settings at
`/admin/config/services/mapkit/providers/gmap`. Enter your API key there, as
described in [Configuration](../configuration/index.md).
