# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core **Link** (`link`), **Media** (`media`), and **Media Library**
  (`media_library`) — these are dependencies Drupal enables automatically. Media
  Library is what gives editors the image‑selection UI.

> **Note on security coverage:** this project is **not** covered by Drupal's
> security advisory policy. Weigh that before using it on a high‑exposure
> production site, and keep it updated.

## Install with Composer

From the project root:

```bash
composer require drupal/link_advance_attributes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/link_advance_attributes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en link_advance_attributes -y
```

## Verify it worked

On a bundle that has a Link field, open **Manage form display** and confirm the
module's link widget is selectable; set it, then on **Manage display** choose its
formatter. Edit a piece of content and confirm you can attach a media image to a
link and that it renders on the page.
