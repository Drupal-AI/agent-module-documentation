# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** (`media`) and **Media Library** (`media_library`) modules
  enabled — Drupal will enable them for you as dependencies if they aren't already.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_thumbnail_override -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_thumbnail_override -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_thumbnail_override -y
```

That's all it takes. There is no required configuration — the overridden
thumbnails appear immediately.

## Verify it worked

Go to **Content → Media** and open the Media Library (for example via **Add
media**, or the media modal on any Media reference field). Non‑image items —
documents, videos, audio — should now show an icon that reflects their file
extension instead of the generic placeholder. Items whose extension has no
specific icon fall back to a generic icon, sized consistently with the rest of
the grid.
