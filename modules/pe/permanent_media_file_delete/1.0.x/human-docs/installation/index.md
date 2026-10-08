# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`) — part of Drupal core.
- The **Media File Delete** module (`media_file_delete`) — this module builds
  directly on top of it, and Drupal will require it as a dependency.

This project has **no security advisory coverage** and is minimally maintained,
so review it before using it on a production site — and remember it deletes files
irreversibly.

## Install with Composer

From the project root:

```bash
composer require drupal/permanent_media_file_delete -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Media File Delete and any
other shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/permanent_media_file_delete -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en permanent_media_file_delete -y
```

Enabling it also enables **Media File Delete** and core **File** if they are not
already on.

## Verify it worked

Create a media item, then edit it and replace its file with a different one and
save. Go to **Content → Files** (`/admin/content/files`) — the original file
should no longer be listed, confirming the old file was removed on replace.
