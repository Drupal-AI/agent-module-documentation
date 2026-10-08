# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media Library** module (`media_library`), which is pulled in as a
  dependency (and which in turn requires core Media). Make sure you have some
  media types set up.
- **Optional:** [Admin Toolbar](https://www.drupal.org/project/admin_toolbar)'s
  Extra Tools submodule — if it's enabled, the bulk‑upload link is nested under
  Content → Media in the toolbar.

There are no third‑party Composer or PHP library requirements — no DropzoneJS or
other JavaScript library is bundled.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_bulk_upload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_library_bulk_upload -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_bulk_upload -y
```

This enables Media Library alongside it. There are no submodules.

## Grant the permissions

Out of the box, every media type is offered on the bulk‑upload page, but a user
still needs the right permission to use it. The module generates a permission per
media type of the form `use media {type} bulk upload form` (plus core's
**Administer media**, which acts as a super‑permission). Grant them at **People →
Permissions**, or from Drush, for example:

```bash
drush role:perm:add content_editor 'use media image bulk upload form'
```

See [Configuration](../configuration/index.md) for the full permission model and
how to limit which media types are offered.

## Verify it worked

As a user with a bulk‑upload permission, visit
`/admin/content/media/bulk-upload`. You should see a list of the media types you
can bulk‑upload; picking one opens the Media Library scoped to that type.
