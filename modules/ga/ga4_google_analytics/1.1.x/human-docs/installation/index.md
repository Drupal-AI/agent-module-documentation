# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no other module dependencies and no third-party Composer or PHP library
requirements. If you want cookie-consent integration you will separately install a
consent manager such as **Klaro** (`drupal/klaro`), but that is optional and not
required for tracking.

## Install with Composer

From the project root:

```bash
composer require drupal/ga4_google_analytics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ga4_google_analytics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ga4_google_analytics -y
```

There are no submodules. Enabling the module does **not** start tracking on its own —
there is no default configuration, so nothing happens until you enter a Measurement
ID on the settings form. Head to [Configuration](../configuration/index.md) next.

## Grant the permission

The settings form is gated by a single permission — grant it at **People →
Permissions**:

- **GA4 Google Analytics Settings** — access to the settings form. Because editing it
  changes site-wide tracking markup, treat it as sensitive and grant it only to
  trusted roles.

Note: the permission's internal machine name is the misspelled `ga4 configre` (not
`ga4 configure`), which only matters if you assign it via config or
`drush role:perm:add`.
