# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10.0 || ^11`).
- The **Feeds** module (`feeds`) — a hard dependency; the plugins plug into Feeds.
- The **Media** system enabled, since files are read from a media‑reference field.

There are no third‑party PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_files_by_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Feeds and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_files_by_media -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_files_by_media -y
```

Drupal enables the Feeds dependency automatically if it isn't already on.

## Verify it worked

Create a feed type at **Structure → Feed types** and confirm that **Fetch Resource
from media field** appears in the **Fetcher** options and **Media field parser**
appears in the **Parser** options. If both are present, the module is ready to
configure.
