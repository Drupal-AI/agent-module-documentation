# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Google / YouTube Data API v3 key** and a YouTube **channel ID** (needed to show a gallery
  — see [Configuration](../configuration/index.md)).
- The server must allow outbound HTTP and have **`allow_url_fopen`** enabled — the module fetches
  the channel's videos with `file_get_contents`.
- **For the optional upload feature only:** the **`google/apiclient`** PHP library (v2+) and a
  Google OAuth client ID / secret. The read/gallery side does **not** need this library.

## Install with Composer

From the project root:

```bash
composer require drupal/youtube_gallery -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as needed.
The module lists `google/apiclient` in its own `composer.json`, so a Composer install is the
cleanest way to get the upload library at a pinned version.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/youtube_gallery -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en youtube_gallery -y
```

## Set the permission

The module adds one permission, **`administer youtube_gallery`** (marked *restrict access*),
which gates the settings form, the status page, and the upload form. Grant it only to trusted
administrators at **People → Permissions**. The public per-video play page uses core's *access
content*.

## Optional: install the Google API client for uploads

Only needed if you want the Drupal-to-YouTube upload feature. Prefer the Composer dependency
above (it gives you a pinned version). Alternatively, the module bundles a Drush command that
downloads the library from GitHub:

```bash
drush ytg:libraries              # install into DRUPAL_ROOT/libraries
drush ytg:libraries web/libraries   # or a custom path
```

Note that this command pulls the client from GitHub's `master` branch (a moving target) over
HTTPS and you then run `composer install` inside the downloaded directory to fetch its own
dependencies — which is why the Composer route is recommended. See
[`agent/drush/commands.md`](../agent/drush/commands.md) for details.

There are no submodules.
