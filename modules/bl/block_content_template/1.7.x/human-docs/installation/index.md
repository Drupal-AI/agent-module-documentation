# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Block content** module (`block_content`) enabled — this provides custom
  (content) blocks, and Drupal enables it automatically as a dependency.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/block_content_template -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/block_content_template -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en block_content_template -y
```

There are no submodules and nothing to configure. After enabling, clear caches
(`drush cr`) and every custom block is rendered through the new template. To start
theming, add `block-content--*.html.twig` files to your active theme — see
[the overview](../index.md#how-to-use-it).
