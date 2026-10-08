# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- The **Purge** module at **8.x-3.3 or newer** (`purge`), with a **tags-header
  plugin** configured (e.g. a Cache-Tags header for your reverse proxy). Purge is
  pulled in automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/purge_uncacheable_tagsheaders -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/purge_uncacheable_tagsheaders -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en purge_uncacheable_tagsheaders -y
```

There is nothing to configure — as long as a Purge tags-header plugin is set up,
the headers begin appearing on `no-cache` responses immediately.

## Verify it worked

1. Make sure a Purge **tags-header plugin** is configured under **Configuration →
   Development → Performance → Purge**.
2. Request an endpoint that Drupal marks `no-cache` — a POST GraphQL request is
   the canonical example — and inspect the response headers. You should now see
   your configured cache-tags header (for example `Cache-Tags`) present, where it
   previously would have been absent.
