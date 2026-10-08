# Installation

## Requirements

- **Drupal 9.4 or 10** (`core_version_requirement: ^9.4 || ^10`).
- **PHP 8.0** or newer.
- No other modules are required. Two things are worth having ready: a **Site24x7
  account with a RUM Monitor** already set up (that is where your RUM key comes
  from), and — if you use it — the **Content-Security-Policy** module, since you will
  need to allow the Site24x7 datacentre host there.

## Install with Composer

From the project root:

```bash
composer require drupal/site24x7 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/site24x7 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en site24x7 -y
```

## Verify it worked

Enabling the module is not enough on its own — you still need to enter a RUM key. Once
you have (see [Configuration](../configuration/index.md)), load a public page and view
its HTML source: you should find the Site24x7 RUM beacon script referencing your
datacentre's host with your app key appended. If your site uses a Content-Security-
Policy, confirm the datacentre host is allowed so the browser does not block the
beacon.
