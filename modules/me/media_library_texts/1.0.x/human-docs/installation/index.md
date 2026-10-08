# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media Library** module enabled (Drupal enables it automatically as a
  dependency).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_texts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_texts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_texts -y
```

## Verify it worked

Open the module's settings form (see [Configuration](../configuration/index.md)),
change one of the texts — for example the **"Add media"** button — and save. Then
open a Media Library widget (from any media field's "Add media" dialog) and confirm
your new wording appears.
