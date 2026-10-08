# Installation

## Requirements

- **Drupal 8.9, 9, 10, or 11** (`core_version_requirement: ^8.9 || ^9 || ^10 || ^11`).
- A **Google Tag Manager container ID** (in the format `GTM-XXXXX`), created in
  your GTM account.

There are no third‑party Composer packages or PHP libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/really_simple_google_tag -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/really_simple_google_tag -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en really_simple_google_tag -y
```

## Verify it worked

Open the module's settings form (see [Configuration](../configuration/index.md)),
enter at least one GTM container ID, and save. Then load a front‑end page and view
its HTML source — you should see the Google Tag Manager snippet for your container.
