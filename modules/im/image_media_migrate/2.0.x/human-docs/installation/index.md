# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Media** module (`media`).
- Core's **Image** module (`image`).

Both dependencies are enabled automatically when you turn on Image Media Migrate.
Before you migrate anything, make sure you have a working **backup** of your
database and files.

## Install with Composer

From the project root:

```bash
composer require drupal/image_media_migrate -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_media_migrate -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_media_migrate -y
```

This also enables the Media and Image modules if they aren't already on.

## Verify it worked

Go to **Configuration → Media → Media Migrate**. You should see the migration form
where you can pick a content type, a source field and a destination field. Do not
run it against production content until you've tested it on a copy — see the main
guide's "How to use it".
