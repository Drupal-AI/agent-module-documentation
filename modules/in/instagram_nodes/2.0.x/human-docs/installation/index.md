# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No modules outside Drupal core are required.
- On the Instagram/Meta side: an **Instagram API access token**, which you
  generate by creating a Meta app and adding an Instagram test user (see Meta's
  documentation on creating an app with Instagram login).
- **Cron** running on your site, since imports happen on cron by default.

## Install with Composer

From the project root:

```bash
composer require drupal/instagram_nodes -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instagram_nodes -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instagram_nodes -y
```

Enabling the module creates the **`instagram_post`** content type that imported
posts are stored in.

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), and check that an
**Instagram post** content type now exists at **Structure → Content types**. Then
continue to [Configuration](../configuration/index.md) to add your access token and
run your first import.
