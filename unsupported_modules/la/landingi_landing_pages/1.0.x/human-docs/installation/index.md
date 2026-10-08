# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Landingi account** and an **API key** from it (see
  [Configuration](../configuration/index.md)).

There are no third‑party PHP library requirements beyond what Composer installs.

## Install with Composer

The Composer package name is **`drupal/landingi`** (not
`drupal/landingi_landing_pages`). From the project root:

```bash
composer require drupal/landingi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/landingi -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

The module's machine name is `landingi_landing_pages`:

```bash
drush en landingi_landing_pages -y
```

## Verify it worked

After enabling, open the module's settings and supply your Landingi API key as
described in [Configuration](../configuration/index.md). A successful connection —
being able to list or import your Landingi pages — confirms the setup.
