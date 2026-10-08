# Installation

## Requirements

- **Drupal 10.3+ or Drupal 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1 or newer.**
- The **Search API** module (`search_api`).
- The **Scolta PHP library** (`tag1/scolta-php`, `^1.3.0`), which is installed
  automatically as a Composer dependency and bundles the Pagefind WASM runtime and
  frontend assets.
- Optionally, the **Drupal AI** module if you want to route query expansion and
  summarisation through it (48+ providers, with Key module support, rate limiting
  and token tracking). This is only needed for the optional AI features.

## Install with Composer

From the project root, using the package name from the module's own documentation:

```bash
composer require tag1/scolta-drupal -W
```

> **Heads-up on the package name.** The module's documentation uses
> `tag1/scolta-drupal` (shown above), while our catalog records the package as
> `drupal/scolta`. Prefer the module's own `tag1/scolta-drupal`; it brings the
> `tag1/scolta-php` library along automatically. The `-W`
> (`--with-all-dependencies`) flag lets Composer update shared dependencies as
> needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require tag1/scolta-drupal -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scolta -y
```

Enabling deploys the browser bundle into your public files directory
(`public://scolta-assets`) and queues the first index build for the next cron run.

## Updating from an earlier release

After a Composer update run the database updates and rebuild caches:

```bash
drush updb -y
drush cr
```

In 1.4.0 the browser bundle (JS/CSS/WASM) is no longer served from the module
directory — it deploys to `public://scolta-assets` and is refreshed on every cache
rebuild. If anything on your site hardcoded the old `modules/.../scolta/js/` asset
paths, update it to the deployed location.

## Verify it worked

After enabling, go to **Configuration → Search and metadata → Search API**. You
should be able to add a new server and see **Scolta Pagefind** offered as a
backend. The full setup — creating the server and index, building the index and
placing the search block — is covered in [Configuration](../configuration/index.md).
