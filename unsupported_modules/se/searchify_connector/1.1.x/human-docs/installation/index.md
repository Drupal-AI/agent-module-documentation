# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **System** module (always present on a Drupal site).
- A **Searchify account and API credentials** — the module is a client for the
  Searchify hosted service, so you need an API key from Searchify to configure it.

There are no extra PHP or third-party library requirements.

## Install with Composer

From the project root — note the Composer package is **`drupal/searchifyai`**,
which differs from the module's machine name `searchify_connector`:

```bash
composer require drupal/searchifyai -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/searchifyai -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable it by its machine name:

```bash
drush en searchify_connector -y
```

## Verify it worked

After enabling, head to the module's settings to add your Searchify credentials —
see [Configuration](../configuration/index.md). Until credentials are set the
`/searchify` page has nothing to query.
