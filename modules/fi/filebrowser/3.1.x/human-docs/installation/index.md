# Installation

## Requirements

Filebrowser needs:

- **Drupal 10 or newer** (`core_version_requirement: >=10`).
- Core's **Node** (`node`) and **System** (`system`) modules — both are part of a
  standard Drupal install and are enabled automatically as dependencies.

There are no third‑party Composer libraries required. If you want to browse a
remote file system (Amazon S3, Dropbox, etc.), the **Flysystem** module and a
matching adapter are suggested but not required.

## Install with Composer

From the project root:

```bash
composer require drupal/filebrowser -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filebrowser -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en filebrowser -y
```

Enabling it creates the `dir_listing` content type. Note that Filebrowser grants
**no permissions by default** — until you grant them per role (see
[Configuration](../configuration/index.md)), even viewing a listing is not
allowed.

## Submodule — Filebrowser Extra

Filebrowser ships one optional submodule, **Filebrowser Extra**
(`filebrowser_extra`). It is a small example that uses the module's metadata event
API to add a **Modified** date column to listings. Enable it only if you want that
column:

```bash
drush en filebrowser_extra -y
```

## Verify it worked

Go to **Content → Add content** and confirm a **Directory listing** type is
available. Grant your account the `view listings` (and `download files`)
permissions, create a listing pointing at a folder that has some files in it, and
visit the node — you should see the folder's contents as a browsable table.
