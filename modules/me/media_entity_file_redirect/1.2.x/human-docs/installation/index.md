# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`; the
  Composer constraint targets core `^10 || ^11`).
- Core's **Media** module (`media`) enabled — Drupal turns it on automatically as a
  dependency. You need at least one media type whose source is the core **File**
  source (for example a "Document" or "PDF" type).
- No third-party Composer or PHP library requirements.

Optional:

- **[Linkit](https://www.drupal.org/project/linkit)** version **6.0.1 or newer**
  (older versions conflict) — only needed if you want editors to insert
  `/document/{id}` links from the CKEditor link dialog.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_file_redirect -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_entity_file_redirect -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_file_redirect -y
```

There are no submodules. The `/document/{id}` route now exists, but it returns a
404 for every media type until you switch the feature on for that type — head to
[Configuration](../configuration/index.md) to do that.
