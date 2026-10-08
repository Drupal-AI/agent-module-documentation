# Installation

## Requirements

- **Drupal 11.1 or newer** (`core_version_requirement: ^11.1`).
- Core's **Layout Builder** module (`layout_builder`) enabled — Drupal enables it
  automatically as a dependency when you turn on Layout Builder Ids.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_ids -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_ids -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_ids -y
```

Once enabled, the Block ID and Section ID fields are on by default, so they
appear in the Layout Builder forms immediately. If you want to change that, or to
turn one of them off, visit **Configuration → User interface → Layout Builder
Ids** (`/admin/config/user-interface/layout-builder-ids`) — see
[the settings section](../index.md#where-it-lives-in-the-admin-menu) of the
overview.

## Verify it worked

Edit any layout with Layout Builder, add or configure a block, and confirm you
see a **Block ID** field. Enter an id, save the layout, and check the page source
— the rendered block should carry your chosen `id` attribute.
