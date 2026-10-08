# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), which Drupal enables by default.
- On the Instagram/Meta side: a **Facebook/Instagram app** registered at
  <https://developers.facebook.com> with Instagram Basic Display set up, plus an
  Instagram account you can add as a tester (see [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/instagram_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/instagram_field -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en instagram_field -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`), and that a
settings form appears at **Configuration → Web services → Instagram Field**. Then
continue to [Configuration](../configuration/index.md) to connect your app and
authenticate.
