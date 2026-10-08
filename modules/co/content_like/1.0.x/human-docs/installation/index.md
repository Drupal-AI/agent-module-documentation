# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Node** module (`node`) — enabled on almost every site.
- Core's **Block Content** module (`block_content`) for liking custom blocks.

Drupal will enable both dependencies automatically when you turn on Content Like.
There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_like -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_like -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_like -y
```

## Verify it worked

The like widget does not appear until you enable it for at least one bundle. Head
to [Configuration](../configuration/index.md), tick a content type (for example
*Article*), and save. Then view a piece of that content — you should see the like
control with a count that increments when you click it, without a page reload.
