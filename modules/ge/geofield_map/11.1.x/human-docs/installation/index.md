# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Geofield** module (`drupal/geofield`, `^1.31 || ^10.3`) — this is a hard
  dependency and provides the `geofield` field type that Geofield Map maps and
  displays. Composer pulls it in for you.
- A **Google Maps API key** for the mapping and geocoding features. This is not a
  Composer requirement, but the maps and address geocoding won't work without it.
  You add it later on the settings form.

Optionally, the **Key** module (`drupal/key`) lets you store the Google Maps API
key as a Key entity instead of plain config — the settings form automatically
switches to a key selector when Key is enabled.

## Install with Composer

From the project root:

```bash
composer require drupal/geofield_map -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Geofield and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/geofield_map -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geofield_map -y
```

Enabling Geofield Map also enables Geofield if it isn't already on.

## Submodule — Geofield Map Extras

Geofield Map ships one optional submodule, **Geofield Map Extras**
(`geofield_map_extras`), which adds two lighter‑weight display formatters: a
**static Google Map image** and a **JavaScript‑free iframe embed**. Enable it
only if you need those cheaper formatters:

```bash
drush en geofield_map_extras -y
```

## Verify it worked

After enabling, go to **Configuration → System → Geofield Map settings**
(`/admin/config/system/geofield_map_settings`) and confirm the settings form
loads. Then add a Geofield field to a content type and set its form widget to
**Geofield Map** to see the interactive input map. See
[Configuration](../configuration/index.md) for the settings and per‑display
setup.
