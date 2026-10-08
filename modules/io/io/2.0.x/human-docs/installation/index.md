# Installation

## Requirements

Intersection Observer builds on a couple of other modules:

- **Drupal 9.4 or newer** (`core_version_requirement: >=9.4`), including Drupal
  10 and 11.
- Core's **Views** module (`views`) — enabled with Drupal core.
- **Blazy 3.0 or newer** (`blazy:blazy (>= 3.x)`) for IO 2.0+. Keep the bLazy
  library enabled — it is what provides the graceful fallback for older browsers.

## Install with Composer

Requiring the module with the `-W` flag pulls in Blazy at a compatible version:

```bash
composer require drupal/io -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/io -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable Intersection Observer together with its Views and Blazy dependencies:

```bash
drush en io -y
```

Drupal enables Views and Blazy automatically as dependencies.

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **IO Browser** | `io_browser` | Adds an IO infinite‑pager integration for Entity Browser. Enable it only if you use Entity Browser and want its results to page in on scroll. |

Enable it with `drush en io_browser -y` if you need it.

## Verify it worked

Set up one View with an AJAX Intersection Observer pager (see "How to use it" on
the [overview page](../index.md)) and scroll to the bottom of its results — the
next page should load automatically without a click. If lazy‑loaded blocks are
enabled, an AJAX block should populate as it scrolls into view.
