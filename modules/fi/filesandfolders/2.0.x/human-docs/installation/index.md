# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`). Note this branch does
  not declare Drupal 11 support.
- A number of core modules, all enabled as dependencies: **Node**, **Views**,
  **File**, **Image**, **Field**, **Field UI**, **User**, **Datetime**, **System**,
  and **Options**.
- For thumbnail generation of Office documents, the server needs **LibreOffice**
  (the `soffice` binary) available, and **Imagick** for PDF/image thumbnails. These
  are server‑side tools the module shells out to; without them, thumbnails for those
  formats won't be produced.

> **Heads up:** This project is **not covered by Drupal's security advisory
> policy** and is still under active development. Review it before using it on a
> production site, and restrict its permissions tightly.

## Install with Composer

> **Watch the names.** The Composer package and on‑disk directory are
> `filesandfolders`, but the module's **machine name is `files_and_folders`** — use
> that with Drush.

From the project root:

```bash
composer require drupal/filesandfolders -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/filesandfolders -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en files_and_folders -y
```

## Grant permissions carefully

Files and Folders ships several fine‑grained permissions — access the interface;
create, edit, and delete own or any folder and file content; view public and
private items; manage root folders; and set options. Review them at **People →
Permissions** (`/admin/people/permissions`).

Because this module handles uploads and file access and is not security‑covered,
be conservative: grant upload and management permissions only to trusted roles, and
**do not** extend them to anonymous or untrusted users.

## Verify it worked

Visit **`/admin/config/files-and-folders/settings`** to confirm the settings form
loads, then visit **`/files-and-folders`** (or place the block) and try creating a
folder and uploading a file. Continue to [Configuration](../configuration/index.md)
to choose your storage scheme and layout.
