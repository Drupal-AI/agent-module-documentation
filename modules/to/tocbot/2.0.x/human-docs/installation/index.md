# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- No other Drupal module dependencies and no PHP library requirements.
- The **Tocbot JavaScript library**, which the module loads from a CDN by default —
  so nothing extra to install for a standard online site. See *Hosting the library
  locally* below if you need it served from your own server.

## Install with Composer

From the project root:

```bash
composer require drupal/tocbot -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tocbot -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tocbot -y
```

Enabling the module makes the **Tocbot TOC** block and the settings form available,
but no table of contents appears until you place the block — see
[Configuration](../configuration/index.md).

## Hosting the library locally (optional)

By default Tocbot pulls the library from a CDN (`cdnjs.cloudflare.com`). If you
prefer to serve it yourself — for offline environments or a stricter Content
Security Policy — download the Tocbot distribution and place both files here:

```
web/libraries/tocbot/dist/tocbot.min.js
web/libraries/tocbot/dist/tocbot.css
```

When both files exist on disk the module automatically switches to the local copies;
otherwise it falls back to the CDN. No configuration change is needed either way.
