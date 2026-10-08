# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** and **Media Library** modules enabled (Drupal enables them
  automatically as dependencies).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_library_favorites -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_library_favorites -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_library_favorites -y
```

## Grant the permission

Nobody can favourite media until you grant the permission. Go to **People →
Permissions** (`/admin/people/permissions`) and grant **allow media favorites** to
the roles that should be able to mark favourites.

## Verify it worked

Log in as a user who has the **allow media favorites** permission and open the Media
Library (for example from a media field's "Add media" dialog). You should be able to
toggle a media item as a favourite, and a **Favourites** link should appear
alongside the **Grid** and **Table** views, showing only your favourited media.
