# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11**
  (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- Core's **Image** module (`image`) — you will have this on any standard site.
- The **jQuery UI** module (`jquery_ui`) — required, and pulled in by Composer.
- Internet access at page render for the CDN‑hosted zoom library (or a vendored
  local copy — see the note below).

## Install with Composer

From the project root:

```bash
composer require drupal/magnify -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including the jQuery UI module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/magnify -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en magnify -y
```

Drupal enables the Image and jQuery UI dependencies automatically.

## Production note — the CDN asset

Magnify's library definition loads its zoom JavaScript from
`cdn.jsdelivr.net/gh/ninjadrupal/magnifyjs@1.0.0`. The reference is version‑pinned,
but it is still fetched from a third‑party host at page load. For production, or
any site with a strict Content Security Policy or offline requirement, download
the asset, place it locally (for example under `/libraries`), and point the
module's `magnify.libraries.yml` at the local file.

## Verify it worked

Go to a **Manage display** screen for an entity that has an image field (for
example `admin/structure/types/manage/page/display`). The **Magnify Image
Viewer** option should appear in that field's formatter list. Selecting it,
saving, and viewing an entity with an image should give you a hover‑zoom loupe.
See the [main guide](../index.md) for the loupe size and zoom settings.
