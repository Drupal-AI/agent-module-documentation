# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.1 or higher.**
- Drupal core's **CKEditor 5**, enabled with at least one text format using it.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/ckeditor5_mentions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ckeditor5_mentions -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ckeditor5_mentions -y
```

## Verify it worked

Go to **Configuration → Content authoring → Mention Feeds**
(`/admin/config/content/mention-feed`) — the Mention Feeds admin collection should
load. From there, follow the [Configuration](../configuration/index.md) guide to
create a feed and enable it on a text format.
