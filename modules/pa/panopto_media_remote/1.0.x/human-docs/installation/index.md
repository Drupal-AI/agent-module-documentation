# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Media Remote** module (`media_remote`) — Panopto Media Remote extends it
  with a Panopto provider. Composer installs it for you with the `-W` flag below.

## Install with Composer

From the project root:

```bash
composer require drupal/panopto_media_remote -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Media Remote.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/panopto_media_remote -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en panopto_media_remote -y
```

Drupal enables Media Remote automatically as a dependency.

## A note on third-party embeds

This module embeds video that is hosted on and governed by **Panopto**. Loading a
Panopto embed makes a request to Panopto's servers and is subject to Panopto's own
access controls and captions. Make sure your site's privacy notice covers the
third-party request, and that the recordings you publish are captioned and
playable by the visitors who will see them.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media`), add a media type
that uses the **Remote Media URL** source, and open its **Manage display**. If
**Remote Media - Panopto** is available as a formatter, the module is installed
correctly. Continue with "How to use it" in the [overview](../index.md).
