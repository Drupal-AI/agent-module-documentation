# Installation

## Requirements

- **Drupal 10.3+ or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules —
  the Video type is a media type, so these must be on.
- **Field Group** (`field_group`) — used to group fields on the Video form.
- **Acquia CMS Common** (`acquia_cms_common`) — the shared layer for the Acquia CMS
  family.

Drupal enables all of these automatically as dependencies. Composer pulls in the
Field Group project for you.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_cms_video -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Field Group,
Acquia CMS Common and update shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_cms_video -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_cms_video -y
```

Enabling it turns on Media, Media Library, Field Group and Acquia CMS Common, then
installs the Video media type and its displays.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media`) and confirm a
**Video** type is listed, then try **Content → Media → Add media → Video** to see
the ready-made form. There is no configuration step required — the type is usable
immediately.
