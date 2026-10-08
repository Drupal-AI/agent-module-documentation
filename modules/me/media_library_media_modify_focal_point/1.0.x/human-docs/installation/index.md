# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- The **Media Library Media Modify** contributed module — this bridge extends its
  modals.
- The **Focal Point** contributed module (`drupal/focal_point`) — this bridge stores
  the focal point it manages.

Install and configure both companion modules first; on their own they don't
interoperate for this workflow, which is exactly the gap this bridge fills. There
are no third‑party Composer library requirements beyond those modules.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_media_modify_focal_point -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If they aren't present yet, also require the companions:

```bash
composer require drupal/focal_point -W
# and the Media Library Media Modify module per its project page
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_media_modify_focal_point -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_media_modify_focal_point -y
```

Make sure the *Media Library Media Modify* and *Focal Point* modules are enabled too.

## Verify it worked

With all three modules enabled and Focal Point configured on your image media, open
the **Media Modify** modal from the Media Library, set the image's focal point, and
save the modal. Confirm the focal point is retained (and that focal‑point image
styles crop around it) — which it would not be without this bridge.
