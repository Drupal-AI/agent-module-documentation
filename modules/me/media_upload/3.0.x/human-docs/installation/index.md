# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8 || ^9 || ^10`).
- Core's **Media** module (`media`).
- The **DropzoneJS** module (`dropzonejs`) — it supplies the drag‑and‑drop upload
  widget. Installing Media Upload with Composer pulls this in as a dependency.
- **Media bundles already configured** for each file type you intend to upload —
  each with a file (or image) reference field. Media Upload reuses the allowed
  extensions and maximum file size from those fields, so set them up first. Core
  already provides **Image** and **File** media types; add video/audio/document
  types (or use contrib helpers) as needed.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_upload -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install DropzoneJS and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_upload -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_upload -y
```

DropzoneJS and Media are enabled automatically as dependencies if they are not
already on.

## Grant permissions

At **People → Permissions** (`/admin/people/permissions`) grant:

- **`upload media`** — to the roles that should be able to use the bulk upload
  form at `/media/upload`.
- **`administer media_upload configuration`** — to administrators who set the
  bundle mapping and size limits.
- The relevant **DropzoneJS** upload permissions, which the upload widget also
  requires.

## Verify it worked

Once you have mapped your bundles on the [Configuration](../configuration/index.md)
page, visit `/media/upload` as a user with `upload media`. You should see the
drag‑and‑drop DropzoneJS area. Drop a test file of an allowed type, submit, and
confirm a new media entity appears under **Content → Media**
(`/admin/content/media`).
