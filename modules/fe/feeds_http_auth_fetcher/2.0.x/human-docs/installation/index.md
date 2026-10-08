# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **Feeds** module (`drupal/feeds`). The fetcher plugin subclasses Feeds' own
  HTTP fetcher, so Feeds must be installed and enabled.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds_http_auth_fetcher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies, including Feeds, as needed. If you don't already have Feeds, install
it too:

```bash
composer require drupal/feeds -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/feeds_http_auth_fetcher -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds_http_auth_fetcher -y
```

Enable Feeds as well if it isn't already on (`drush en feeds -y`). Once enabled,
select the **Download from URL with Authorization** fetcher on your feed type and
fill in the credentials per feed — see the
[overview](../index.md#how-to-use-it) for the walk‑through.
