# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Content Moderation** (`content_moderation`) and **Book** (`book`)
  modules — Drupal enables them as dependencies when you turn on Book Moderation
  Sync. You will also need a moderation workflow configured for your book content.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/book_moderation_sync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/book_moderation_sync -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en book_moderation_sync -y
```

Once enabled — and with a moderation workflow applied to your book content — state
changes on a book page propagate to its children automatically. See
[How to use it](../index.md#how-to-use-it).
