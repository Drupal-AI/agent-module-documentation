# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block** module (`block`), which the module depends on and Drupal will
  enable automatically as a dependency — the history is displayed through a block.

There are no third‑party Composer or PHP library requirements.

> **Security coverage:** this module is **not** covered by Drupal's security
> advisory policy. Weigh that against your site's risk tolerance before using it
> on a public or sensitive site.

## Install with Composer

From the project root:

```bash
composer require drupal/last_visited_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/last_visited_pages -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en last_visited_pages -y
```

## Verify it worked

Log in and browse a few pages, then go to **Structure → Block layout**, place the
**Last Visited Pages** block in a region, and reload. The block should list the
pages you just visited with their titles, URLs, and visit times. Tune how many
links it shows in [Configuration](../configuration/index.md).
