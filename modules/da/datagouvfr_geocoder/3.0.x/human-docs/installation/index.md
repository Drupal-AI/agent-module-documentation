# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Geocoder** contrib module (`drupal/geocoder`, `^4.0`) — this is a hard
  dependency; the provider is useless without it.
- Outbound HTTPS access from your server to `https://api-adresse.data.gouv.fr/`.
- No API key and no extra PHP libraries are needed — the BAN service is open and
  free.

## Install with Composer

From the project root:

```bash
composer require drupal/datagouvfr_geocoder -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Geocoder
module and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/datagouvfr_geocoder -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en datagouvfr_geocoder -y
```

This also enables Geocoder if it isn't on already.

## Verify it worked

Go to **Configuration → System → Geocoder → Providers**
(`/admin/config/system/geocoder/providers`) and add a new provider. The provider
type **adresse.data.gouv.fr** should appear in the list. Once added, wire it into
a Geocoder field or provider chain as described in the
[main guide](../index.md#how-to-use-it).
