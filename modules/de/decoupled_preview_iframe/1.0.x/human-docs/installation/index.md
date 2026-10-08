# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies — it works with a stock Drupal install.

There are no third-party Composer or PHP library requirements. What you *do*
need on the other side is a decoupled front-end application that exposes a
preview URL and, ideally, permits being framed by your Drupal domain (see the
note in [Configuration](../configuration/index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/decoupled_preview_iframe -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/decoupled_preview_iframe -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en decoupled_preview_iframe -y
```

Enabling the module does nothing visible on its own — the preview URL is empty
and no content types are selected by default. Head to
[Configuration](../configuration/index.md) to point it at your front end and
choose which content types get the iframe preview.
