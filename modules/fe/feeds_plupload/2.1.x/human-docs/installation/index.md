# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **Feeds** module (`feeds:feeds`) enabled.
- The **Plupload integration** module (`plupload:plupload`) enabled, which in turn
  provides the Plupload JavaScript library.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_plupload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Composer will also bring in the Feeds and Plupload modules
if they aren't present yet.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_plupload -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_plupload -y
```

This also enables Feeds and Plupload if they aren't on yet.

## Verify it worked

First check **Reports → Status report** (`/admin/reports/status`) and confirm the
Plupload library is reported as installed correctly. Then go to
**Structure → Feed types** (`/admin/structure/feeds`), add or edit a Feed type,
and confirm **File upload with Plupload** now appears in the fetcher list.
