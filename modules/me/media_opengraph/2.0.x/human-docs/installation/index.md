# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core's **Media** module enabled — the module's only declared dependency. Drupal
  will enable it for you if it isn't already.
- **Media Library** is recommended (not required) for a smoother editing
  experience.

There are no third‑party Composer or PHP library requirements. Composer is the
supported install method.

## Install with Composer

From the project root:

```bash
composer require drupal/media_opengraph -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_opengraph -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_opengraph -y
```

Enabling the module installs its OpenGraph media source plugin and a default media
type that uses it.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media/types`) and confirm the
OpenGraph media type is present. Then create a media item of that type, enter a
public URL, and check that the fetched title, description, and image populate the
mapped fields as a preview card.
