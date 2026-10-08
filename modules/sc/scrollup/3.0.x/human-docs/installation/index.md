# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11.0`). This range is
  deliberately narrow and **excludes earlier Drupal 10 minors** — confirm your site
  is on at least Drupal 10.3 before installing.
- No dependent modules, no PHP version requirement, and no third-party libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/scrollup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/scrollup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en scrollup -y
```

## Verify it worked

Open a page long enough to scroll and scroll down past the trigger point. The
floating "back to top" button should appear; clicking it should return you to the
top. To adjust its appearance and behaviour, see
[Configuration](../configuration/index.md).
