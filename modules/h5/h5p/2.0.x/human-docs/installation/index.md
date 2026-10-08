# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Field** (`field`) and **File** (`file`) modules — enabled on standard
  sites and pulled in automatically as dependencies.
- Two PHP libraries from the H5P project, installed automatically by Composer:
  - **h5p/h5p-core** (`^1.27`)
  - **h5p/h5p-editor** (`^1.24.4`)

Because H5P stores uploaded packages and generated files, the site's files
directory must be writable (as usual for Drupal). For fetching content types from
the H5P Hub, the site needs outbound internet access.

## Install with Composer

From the project root:

```bash
composer require drupal/h5p -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the h5p‑core and
h5p‑editor libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/h5p -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en h5p -y
```

## Enable in‑browser authoring (H5P Editor submodule)

H5P ships one submodule, **H5P Editor** (`h5peditor`). Enable it to author content
directly in the browser and to install new content types from the H5P Hub:

```bash
drush en h5peditor -y
```

Without it you can still display interactive content by uploading `.h5p` packages,
but you won't have the visual authoring widget or the Hub install flow.

## After enabling

1. Install at least one interactive content type at **Content → H5P Content**
   (`/admin/content/h5p`).
2. Review the global settings at **Configuration → System → H5P** and grant the H5P
   permissions to the appropriate roles — see [Configuration](../configuration/index.md).
