# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A moderation workflow that produces draft forward revisions — typically core's
  **Content Moderation** module — for the redirect to have anything to point to.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/prefer_latest_content -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/prefer_latest_content -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en prefer_latest_content -y
```

## Grant the permission

The module does nothing until you assign its permission. Go to **People →
Permissions**, find **Prefer Latest Content: Force latest if available**
(`prefer latest content`), and tick it for the editor/reviewer roles that should
be redirected to the latest draft. Do not grant it to anonymous users.

## Verify it worked

Log in as a user in a role that holds the permission (but is not an
administrator), create a published node, then save a new draft revision of it
(leaving it in a draft moderation state). Visiting the node's normal URL should
now redirect you to `/node/{nid}/latest` and show the draft. Anonymous visitors,
and administrators, should continue to see the published revision.
