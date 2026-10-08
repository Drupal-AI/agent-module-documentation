# Installation

## Requirements

- **Drupal 8.8+, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- A **Cookiebot account/profile** and a **Google Tag Manager container id** — you
  enter both during configuration.

There are no module dependencies and no third‑party PHP or JavaScript library
requirements (the Cookiebot and GTM scripts load at runtime from their services).

## Install with Composer

From the project root:

```bash
composer require drupal/cookiebot_gtm -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cookiebot_gtm -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookiebot_gtm -y
```

Enabling alone does not connect anything — you must enter your Cookiebot profile and
GTM id on the settings form, and grant the **`access cookiebot gtm config`**
permission to whoever will manage it.

## Verify it worked

After configuring (see [Configuration](../configuration/index.md)), load a page as a
visitor who has not yet consented and confirm the Cookiebot banner appears and that
GTM‑controlled tags do **not** fire until consent is given. The module also provides
a page listing the cookies enabled/available on your site (fetched from your
Cookiebot profile) — a useful cross‑check.
