# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- The **Geofield** module (`geofield`) — Geofield Directions is a formatter for
  Geofield fields, so you need a Geofield to attach it to.

There are no third‑party Composer or PHP library requirements. The "get
directions" link points at Google Maps, which is opened in the visitor's browser;
no API key is required for the basic directions link.

## Install with Composer

From the project root:

```bash
composer require drupal/geofield_directions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Geofield and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/geofield_directions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en geofield_directions -y
```

Drupal will enable `geofield` alongside it if it isn't already on.

## Verify it worked

Go to a content type that has a Geofield, open its **Manage display**, and check
that the Geofield Directions formatter appears as a **Format** option for the
geofield. Set it, save, and view a piece of content with a location — you should
see your "get directions" link, which opens Google Maps at that point when
clicked.
