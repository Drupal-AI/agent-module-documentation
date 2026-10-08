# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **`jaybizzle/crawler-detect`** PHP library, which does the actual bot detection.
  When you install the module with Composer this library is pulled in automatically —
  which is why Composer is the recommended way to install this module.

There are no other module dependencies and no JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/crawlers_cache_context -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`jaybizzle/crawler-detect` library and any shared dependencies as needed. Installing
via Composer (rather than downloading the module by hand) is important here, because
the crawler-detection library must be present for the module to work.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crawlers_cache_context -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crawlers_cache_context -y
```

There is nothing to configure — the module simply makes the cache context available
for code to use.

## Verify it worked

The module has no visible UI, so verify it in code: add the
`crawlers_cache_context` context (or `crawlers_cache_context:googlebot`) to a render
array's `#cache['contexts']`, as shown in "How to use it" in the
[overview](../index.md). Then request the page once with a normal browser user-agent
and once with a crawler user-agent and confirm you get the two different cached
variants.
