# Installation

## Requirements

Media Folders needs:

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Taxonomy**, **Media Library**, and **User** modules — enabled
  automatically as dependencies. (Folders are stored as taxonomy terms, and the
  browser builds on Media Library.)

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_folders -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_folders -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_folders -y
```

On enable, the module installs its folder vocabulary
(`media_folders_folder`) and the optional bulk action.

## After enabling

1. Grant permissions at **People → Permissions**:
   - **Access media folders configuration** — who may open the settings page.
   - Your editors also need the usual **Access media overview** (to browse) and
     the appropriate **Taxonomy** and **Media** permissions to create folders and
     add/edit media (Media Folders reuses core permissions rather than inventing
     its own).
2. Review the [settings](../configuration/index.md), especially the file-extension
   to Media-type mapping used for uploads.
3. Open **Content → Media folders** (`/admin/content/media-folders`) to start
   creating folders and organising media.
