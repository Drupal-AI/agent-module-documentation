# Installation

## Requirements

Profile runs on Drupal 9, 10, or 11 and PHP 7.4 or newer (`^7.4 || ^8.0`). It
depends on:

- **Field** (`field`), **User** (`user`), and **Views** (`views`) — all core
  modules that ship with Drupal.
- **Entity API** (`drupal/entity`, `^1.0`) — a contrib module that Composer pulls
  in automatically. Profile uses it for the per-bundle access permissions on each
  profile type.

Optional, and only pulled in if you ask for them:

- **Token** (`drupal/token`) — adds token support for profile fields.
- **Search API** (`drupal/search_api`) — lets you index user profiles for site
  search.

## Install with Composer

From the project root:

```bash
composer require drupal/profile -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the **Entity
API** dependency at a compatible version.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/profile -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en profile -y
```

This also enables the **Entity API** module it depends on. Once enabled, the
profile-type screens appear under **Configuration → People → Profile types**
(`/admin/config/people/profile-types`).

## Verify it worked

Log in as an administrator and go to `/admin/config/people/profile-types`. You
should see the **Profile types** list with an **+ Add profile type** button:

![The Profile types list after installation](../images/types.png)

If the page loads and the button is present, the module is installed correctly.
Next, review the [Profile types list](../configuration/index.md) and then
[create your first profile type](../creating-a-profile-type/index.md).
