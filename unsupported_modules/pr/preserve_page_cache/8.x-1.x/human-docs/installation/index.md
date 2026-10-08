# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Internal Page Cache** module (`page_cache`) — this module overrides its
  middleware.
- Core's **Path Alias** module (`path_alias`) — used to resolve a request path back
  to `node/<id>` so the node exception works.

Drupal enables both dependencies automatically when you turn on this module.

> **Heads up:** this module is marked *obsolete* and is *seeking a new maintainer*,
> and it targets Drupal 8–10. Evaluate it carefully before adopting it on a
> long-lived site.

## Install with Composer

From the project root:

```bash
composer require drupal/preserve_page_cache -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/preserve_page_cache -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en preserve_page_cache -y
```

The page-cache middleware swap takes effect as soon as the module is enabled —
there is nothing to configure.

## Verify it worked

On a staging copy, cache an anonymous page, then make a change that would normally
invalidate it by tag (for example a block or config change). With this module
enabled, the page should **remain served from cache** until its `max-age` expires
— confirming tags are being dropped. Then edit a **node** and confirm that node's
page *does* clear immediately (the retained `node:<id>` tag). If both behave that
way, the middleware override is active.
