# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- No required module dependencies — Fast Autocomplete runs on core alone.
- **Search API** (`drupal/search_api`) is **optional**: install it only if you want
  to drive suggestions from a Search API index rather than a simple node‑title match.
- A writable **public files** directory (suggestions are cached as JSON files under
  `public://fac-json/…`).
- For keyword highlighting the module uses **mark.js**, loaded from a CDN by default;
  you can instead place a local copy at `/libraries/mark.js/jquery.mark.min.js`.

## Install with Composer

From the project root:

```bash
composer require drupal/fac -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fac -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en fac -y
```

There are no submodules. The module defines one permission, **administer fac
settings**, which gates the configuration pages — grant it to administrators under
**People → Permissions**.

> **Stage File Proxy users:** exclude the `fac-json` directory from Stage File Proxy
> so its cached suggestion files aren't proxied from production.

After enabling, head to [Configuration](../configuration/index.md) to create your
first autocomplete configuration.
