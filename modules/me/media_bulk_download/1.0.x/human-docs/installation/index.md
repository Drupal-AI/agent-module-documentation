# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- Core's **Media** module (`media`) — Drupal enables it automatically as a
  dependency when you turn on Media Bulk Download.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_bulk_download -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_bulk_download -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_bulk_download -y
```

## Grant the permission

The bulk action is controlled by a single permission. Go to **People →
Permissions** (`/admin/people/permissions`), find **Download bulk media**
(`download bulk media`), and tick it for the roles that should be allowed to
bulk-download media. Grant it only to trusted editorial roles, since it lets a
user pull the original files of any media they select into a ZIP.

## Verify it worked

Log in as a user with the new permission and go to the Media Library (**Content →
Media**). Select a couple of media items, open the *Action* dropdown, and confirm
that **Download selected as ZIP** appears. Apply it and you should see a status
message with a working download link.
